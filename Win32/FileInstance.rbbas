#tag Class
Protected Class FileInstance
	#tag Method, Flags = &h0
		Sub Constructor(Path As String)
		  AbsolutePath = RelativeToAbsolute(Path)
		  LastError = GetLastError()
		  'Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyTo(Target As String, Overwrite As Boolean = False) As Boolean
		  Return CopyFileEx(Me.AbsolutePath, Target, Overwrite)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Delete() As Boolean
		  Return DeleteFile(Me.AbsolutePath)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveTo(Target As String, Overwrite As Boolean = False, Flush As Boolean = False) As Boolean
		  Dim flags As Integer = MOVEFILE_COPY_ALLOWED
		  If Overwrite Then flags = flags Or MOVEFILE_REPLACE_EXISTING
		  If Flush Then flags = flags Or MOVEFILE_WRITE_THROUGH
		  
		  Return MoveFileEx(Me.AbsolutePath, Target, flags)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As FolderItem
		  Return GetFolderItem(Me.AbsolutePath)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Win32.FileInstance
		  #If TargetWin32 Then
		    If Index = 0 Then Return Me  //Stream zero is the unnamed main stream
		    
		    If System.IsFunctionAvailable("FindFirstStreamW", "Kernel32") Then
		      Dim buffer As WIN32_FIND_STREAM_DATA
		      Dim sHandle As Integer = FindFirstStream(Me.AbsolutePath, 0, buffer, 0)
		      Dim ret As String
		      
		      If sHandle > 0 Then
		        Dim i As Integer = 1
		        If FindNextStream(sHandle, buffer) Then
		          Do
		            If i = Index Then
		              ret = DefineEncoding(buffer.StreamName, Encodings.UTF16)
		              ret = NthField(ret, ":", 2)
		              Exit
		            ElseIf i >= Index Then
		              Raise New OutOfBoundsException
		            Else
		              i = i + 1
		            End If
		          Loop Until Not FindNextStream(sHandle, buffer)
		        Else
		          Raise New OutOfBoundsException
		        End If
		        
		        Call FindClose(sHandle)
		        Return New Win32.FileInstance(AbsolutePath + ":" + ret + ":$DATA")
		      Else
		        Raise New IOException
		      End If
		    ElseIf System.IsFunctionAvailable("NtQueryInformationFile", "NTDLL") Then
		      Dim fHandle As Integer = CreateFile(AbsolutePath, 0,  FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)
		      If fHandle > 0 Then
		        Dim mb As New MemoryBlock(64 * 1024)
		        Dim status As IO_STATUS_BLOCK
		        NtQueryInformationFile(fHandle, status, mb, mb.Size, 22)
		        Dim currentOffset As Integer
		        For i As Integer = 0 To Index
		          If mb.UInt32Value(currentOffset) > 0 Then
		            currentOffset = mb.UInt32Value(currentOffset)
		            If i = Index Then
		              Return New Win32.FileInstance(AbsolutePath + ":" + mb.WString(24) + ":$DATA")
		            End If
		          Else
		            Raise New OutOfBoundsException
		          End If
		        Next
		      Else
		        Raise New IOException
		      End If
		    Else
		      Raise New PlatformNotSupportedException
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StreamCount() As Integer
		  //Counts the number of data streams attached to a file or directory on an NTFS volume. This count includes the default main stream.
		  //Windows Vista and newer have much better APIs for handling streams than previous versions, so we use those when possible.
		  //On error, returns -1
		  
		  #If TargetWin32 Then
		    If Not System.IsFunctionAvailable("FindFirstStreamW", "Kernel32") And System.IsFunctionAvailable("NtQueryInformationFile", "NTDLL") Then
		      
		      Dim fHandle As Integer = CreateFile(Me.AbsolutePath, 0,  FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0)
		      If fHandle > 0 Then
		        Dim mb As New MemoryBlock(64 * 1024)
		        Dim status As IO_STATUS_BLOCK
		        NtQueryInformationFile(fHandle, status, mb, mb.Size, 22)
		        Dim ret, currentOffset As Integer
		        While True
		          If mb.UInt32Value(currentOffset) > 0 Then
		            currentOffset = currentOffset + mb.UInt32Value(currentOffset)
		            ret = ret + 1
		          Else
		            Exit While
		          End If
		        Wend
		        Return ret
		        
		      Else
		        Return -1
		      End If
		    ElseIf System.IsFunctionAvailable("FindFirstStreamW", "Kernel32") Then
		      Dim buffer As WIN32_FIND_STREAM_DATA
		      Dim sHandle As Integer = FindFirstStream(Me.AbsolutePath, 0, buffer, 0)
		      Dim ret As Integer
		      
		      If sHandle > 0 Then
		        Do
		          ret = ret + 1
		        Loop Until Not FindNextStream(sHandle, buffer)
		      Else
		        Return -1
		      End If
		      Call FindClose(sHandle)
		      Return ret
		    Else
		      Return -1
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StreamCreate(StreamName As String) As Win32.FileInstance
		  //Creates a new named stream for the file or directory specified in target. If creation was successful or if
		  //the named stream already exists, returns a FileInstance corresponding to the stream. Otherwise, returns Nil.
		  //Failure reasons may be: the volume is not NTFS, access to the file or directory was denied, or the target does not exist.
		  
		  #If TargetWin32 Then
		    If Not Me.Exists Then Return Nil
		    Dim fHandle As Integer = CreateFile(Me.AbsolutePath + ":" + StreamName + ":$DATA", 0, FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, CREATE_NEW, 0, 0)
		    If fHandle > 0 Then
		      Call CloseHandle(fHandle)
		      Return New Win32.FileInstance(Me.AbsolutePath + ":" + StreamName + ":$DATA")
		    Else
		      Me.LastError = GetLastError()
		      If Me.LastError = 80 Then  //ERROR_FILE_EXISTS
		        Me.LastError = 0
		        Return New Win32.FileInstance(Me.AbsolutePath + ":" + StreamName + ":$DATA")
		      End If
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Truncate() As Boolean
		  Dim handle As Integer = CreateFile(Me.Name, GENERIC_WRITE, 0, 0, TRUNCATE_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
		  If handle > 0 Then
		    Call CloseHandle(handle)
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AbsolutePath As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim HWND As Integer = CreateFile(Me.AbsolutePath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
			  If HWND = -1 Then
			    LastError = GetLastError()
			    Return False
			  Else
			    Call CloseHandle(HWND)
			    LastError = 0
			    Return True
			  End If
			  
			  
			End Get
		#tag EndGetter
		Exists As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim fn As String = Me.Name
			  Dim ext As String = NthField(fn, ".", CountFields(fn, "."))
			  Return ext
			End Get
		#tag EndGetter
		Extension As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LastError As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return NthField(Me.AbsolutePath, "/", CountFields(Me.AbsolutePath, "/"))
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbsolutePath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Exists"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Extension"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			InitialValue="0"
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
End Class
#tag EndClass
