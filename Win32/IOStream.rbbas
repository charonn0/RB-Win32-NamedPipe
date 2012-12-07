#tag Class
Protected Class IOStream
Implements Readable,Writeable
	#tag Method, Flags = &h0
		Sub Close()
		  Call CloseHandle(Me.Handle)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ConnectPipe(PipeName As String) As Win32.IOStream
		  Dim err As Integer
		  Dim hFile As Integer = Win32.CreateFile("\\.\pipe\" + PipeName, Win32.GENERIC_READ Or Win32.GENERIC_WRITE, 0, 0, Win32.OPEN_EXISTING, 0, 0)
		  err = Win32.GetLastError()
		  Dim stream As New Win32.IOStream(hFile)
		  stream.LastError = err
		  
		  Return stream
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(FileHandle As Integer)
		  #If Not TargetWin32 Then #pragma Error "This class is for Windows only."
		  Me.mHandle = FileHandle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateFileStream(Target As String, CreateDisposition As Integer = 0, Access As Integer = 0, Sharemode As Integer = 0, Flags As Integer = 0) As Win32.IOStream
		  'This function accepts parameters corresponding to those of the CreateFile() Win32 function.
		  'Returns a new instance of Win32.IOStream. Check the returned IOStream's LastError value
		  'to determine whether the file was opened successfully.
		  
		  Dim tmp As Win32.IOStream = New Win32.IOStream(INVALID_HANDLE_VALUE)
		  Dim hFile As Integer
		  
		  If Access = 0 Then Access = GENERIC_ALL
		  If CreateDisposition = 0 Then CreateDisposition = OPEN_EXISTING
		  If sharemode = 0 Then sharemode = FILE_SHARE_READ 'exclusive write access
		  
		  hFile = CreateFile("//?/" + ReplaceAll(Target, "/", "//"), Access, sharemode, 0, CreateDisposition, Flags, 0)
		  
		  If hFile <> INVALID_HANDLE_VALUE Then
		    tmp = New Win32.IOStream(hFile)
		    tmp.LastError = 0
		  Else
		    tmp.LastError = GetLastError()
		  End If
		  
		  Return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateNamedPipe(PipeName As String, OpenMode As Integer, MaxInstances As Integer = - 1, OutBufferSize As Integer = 512, InBufferSize As Integer = 512, DefaultTimeout As Integer = - 1, PipeMode As Integer = 0) As Win32.IOStream
		  Dim err As Integer
		  If MaxInstances = -1 Then MaxInstances = PIPE_UNLIMITED_INSTANCES
		  Dim i As Integer = Win32.CreateNamedPipe("\\.\pipe\" + PipeName, OpenMode, PipeMode, MaxInstances, OutBufferSize, InBufferSize, DefaultTimeout, Nil)
		  err = GetLastError()
		  Dim np As New Win32.IOStream(i)
		  np.LastError = err
		  If Win32.ConnectNamedPipe(np.Handle, Nil) Then 'ConnectNamedPipe blocks until a client connects (TODO: async mode)
		    np.LastError = 0
		  Else
		    np.LastError = Win32.GetLastError()
		  End If
		  Return np
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EOF() As Boolean Implements Readable.EOF
		  Return LastError = -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush() Implements Writeable.Flush
		  If FlushFileBuffers(Me.Handle) Then
		    LastError = 0
		  Else
		    LastError = GetLastError()
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As BinaryStream
		  'Be aware that calling the Close method on either this instance of Win32.IOStream or the
		  'returned BinaryStream will close both.
		  Return New BinaryStream(Me.Handle, BinaryStream.HandleTypeWin32Handle)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String Implements Readable.Read
		  #pragma BoundsChecking Off
		  #pragma Unused encoding
		  Dim mb As New MemoryBlock(Count)
		  Dim read As Integer
		  If ReadFile(Me.Handle, mb, mb.Size, read, Nil) Then
		    If read = mb.Size Then
		      LastError = 0
		    Else
		      LastError = -1 'EOF
		    End If
		  Else
		    LastError = GetLastError()
		  End If
		  
		  Return mb.StringValue(0, mb.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadError() As Boolean Implements Readable.ReadError
		  Return LastError <> 0
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(text As String) Implements Writeable.Write
		  Dim mb As MemoryBlock = text
		  Dim written As Integer
		  If WriteFile(Me.Handle, mb, mb.Size, written, Nil) Then
		    LastError = 0
		  Else
		    LastError = GetLastError()
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteError() As Boolean Implements Writeable.WriteError
		  Return LastError <> 0
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHandle
			End Get
		#tag EndGetter
		Handle As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LastError As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim value, oldvalue As Integer
			  oldvalue = Me.Position
			  value = SetFilePointer(Me.Handle, 0, Nil, FILE_END)
			  Me.Position = oldvalue
			  Me.LastError = GetLastError()
			  Return value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  'Sets the position of the EOF. The file is truncated or expanded on-disk as needed to meet the new EOF.
			  'If the current Position of the file pointer is outside the new length, then then Position is moved to
			  'the new EOF.
			  
			  Dim oldvalue As Integer = Me.Position
			  Me.Position = value
			  If Not SetEndOfFile(Me.Handle) Then
			    Me.LastError = GetLastError()
			  Else
			    Me.LastError = 0
			  End If
			  If oldvalue <= Me.Position Then Me.Position = oldvalue
			End Set
		#tag EndSetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mHandle As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim value As Integer = SetFilePointer(Me.Handle, 0, Nil, FILE_CURRENT)
			  Me.LastError = GetLastError()
			  Return value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Call SetFilePointer(Me.Handle, value, Nil, FILE_BEGIN)
			  Me.LastError = GetLastError()
			  
			  
			  
			End Set
		#tag EndSetter
		Position As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Handle"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastError"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Position"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
