#tag Module
Protected Module Win32
	#tag ExternalMethod, Flags = &h21
		Private Declare Function ConnectNamedPipe Lib "Kernel32" (hPipe As Integer, Overlap As OVERLAPPED) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function ConnectNamedPipe(PipeName As String) As BinaryStream
		  'Connects to the named pipe.
		  'Use CreateNamedPipe to create a new named pipe server.
		  
		  Dim err As Integer
		  Dim hFile As Integer = Win32.CreateFile("\\.\pipe\" + PipeName, Win32.GENERIC_READ Or Win32.GENERIC_WRITE, 0, 0, Win32.OPEN_EXISTING, 0, 0)
		  err = Win32.GetLastError()
		  Dim stream As New BinaryStream(hFile, BinaryStream.HandleTypeWin32Handle)
		  
		  Return stream
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateFile Lib "Kernel32" Alias "CreateFileW" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function CreateNamedPipe(PipeName As String, OpenMode As Integer, MaxInstances As Integer = -1, OutBufferSize As Integer = 512, InBufferSize As Integer = 512, DefaultTimeout As Integer = -1, PipeMode As Integer = 0) As BinaryStream
		  'Creates a new named pipe server and connects it
		  'Use ConnectNamedPipe to create clients that can read and write to an existing named pipe
		  'See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa365150%28v=vs.85%29.aspx
		  'and http://msdn.microsoft.com/en-us/library/windows/desktop/aa365146%28v=vs.85%29.aspx
		  '
		  
		  Dim err As Integer
		  If MaxInstances = -1 Then MaxInstances = PIPE_UNLIMITED_INSTANCES
		  Dim hFile As Integer = Win32.CreateNamedPipe("\\.\pipe\" + PipeName, OpenMode Or Win32.FILE_FLAG_OVERLAPPED, PipeMode, _
		  MaxInstances, OutBufferSize, InBufferSize, DefaultTimeout, Nil)
		  err = Win32.GetLastError()
		  Dim stream As New BinaryStream(hFile, BinaryStream.HandleTypeWin32Handle)
		  
		  If err = 0 Then
		    Dim over As OVERLAPPED
		    over.Internal = 0
		    over.InternalHigh = 0
		    over.Offset = 0
		    over.hEvent = 0
		    If Not Win32.ConnectNamedPipe(stream.Handle(BinaryStream.HandleTypeWin32Handle), over) Then 
		      stream = Nil
		    End If
		  Else
		    stream = Nil
		  End If
		  
		  Return stream
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function CreateNamedPipe Lib "Kernel32" Alias "CreateNamedPipeW" (Name As WString, OpenMode As Integer, PipeMode As Integer, MaxInstances As Integer, OutBufferSize As Integer, InBufferSize As Integer, DefaultTimeOut As Integer, SecurityAttributes As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetLastError Lib "Kernel32" () As Integer
	#tag EndExternalMethod


	#tag Constant, Name = FILE_FLAG_OVERLAPPED, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_ALL, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_READ, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_WRITE, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INVALID_HANDLE_VALUE, Type = Double, Dynamic = False, Default = \"&hffffffff", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OPEN_EXISTING, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPE_ACCESS_DUPLEX, Type = Double, Dynamic = False, Default = \"&h00000003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPE_ACCESS_INBOUND, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPE_ACCESS_OUTBOUND, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPE_TYPE_MESSAGE, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPE_UNLIMITED_INSTANCES, Type = Double, Dynamic = False, Default = \"255", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = OVERLAPPED, Flags = &h1
		Internal As Integer
		  InternalHigh As Integer
		  Offset As UInt64
		hEvent As Integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
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
End Module
#tag EndModule
