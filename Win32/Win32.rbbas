#tag Module
Protected Module Win32
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CloseHandle Lib "Kernel32" (handle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CopyFileEx Lib "Kernel32" Alias "CopyFileExW" (sourceFile As WString, destinationFile As WString, FailIfExists As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateFile Lib "Kernel32" Alias "CreateFileW" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateNamedPipe Lib "Kernel32" Alias "CreateNamedPipeW" (Name As WString, OpenMode As Integer, PipeMode As Integer, MaxInstances As Integer, OutBufferSize As Integer, InBufferSize As Integer, DefaultTimeOut As Integer, SecurityAttributes As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreatePipe Lib "Kernel32" (ByRef ReadPipe As Integer, ByRef WritePipe As Integer, ByRef SecurityAttributes As SECURITY_ATTRIBUTES, BufferSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function DeleteFile Lib "Kernel32" Alias "DeleteFileW" (Path As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindClose Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindFirstStream Lib "Kernel32" (filename As WString, InfoLevel As Integer, ByRef buffer As WIN32_FIND_STREAM_DATA, Reserved As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindNextStream Lib "Kernel32" (FindHandle As Integer, ByRef buffer As WIN32_FIND_STREAM_DATA) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FlushFileBuffers Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetFinalPathNameByHandle Lib "Kernel32" Alias "GetFinalPathNameByHandleW" (FileHandle As Integer, FilePath As Ptr, FilePathSize As Integer, Flags As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetLastError Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LockFile Lib "Kernel32" (FileHandle As Integer, dwFileOffsetLow As Integer, dwFileOffsetHigh As Integer, nNumberOfBytesToLockLow As Integer, nNumberOfBytesToLockHigh As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function MoveFileEx Lib "Kernel32" Alias "MoveFileExW" (sourceFile As WString, destinationFile As WString, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Sub NtQueryInformationFile Lib "NTDLL" (fHandle As Integer, ByRef status As IO_STATUS_BLOCK, FileInformation As Ptr, FILength As UInt32, InfoClass As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathAppend Lib "Shlwapi" Alias "PathAppendW" (firstHalf As Ptr, secondHalf As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathCanonicalize Lib "Shlwapi" Alias "PathCanonicalizeW" (OutBuffer As Ptr, InBuffer As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathGetArgs Lib "Shlwapi" Alias "PathGetArgsW" (path As WString) As WString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ReadFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToRead As Integer, ByRef BytesRead As Integer, Overlapped As Ptr) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function RelativeToAbsolute(RelativePath As String, CurrentDir As FolderItem = Nil) As String
		  //Takes a Relative Path and an optional root directory. Returns a string representing the absolute path
		  //represented by the RelativePath relative to the CurrentDir.
		  //If CurrentDir is Nil then the App.ExecutableFile.Parent directory is used.
		  //
		  //For Example:
		  //Dim f As FolderItem = GetFolderItem("C:\")
		  //Dim abso As String = RelativeToAbsolute("Windows\..\Program Files\MyApp\MyApp Libs\..\MyApp.exe", f)
		  ////abso = C:\Program Files\MyApp\MyApp.exe
		  #If TargetWin32 Then
		    If CurrentDir = Nil Then CurrentDir = App.ExecutableFile.Parent
		    
		    Dim outBuff As New MemoryBlock(1024)
		    outBuff.WString(0) = CurrentDir.AbsolutePath
		    Dim inBuff As New MemoryBlock(1024)
		    inBuff.WString(0) = RelativePath
		    If PathAppend(outBuff, inBuff) Then
		      inBuff.WString(0) = outBuff.WString(0)
		      If PathCanonicalize(outBuff, inBuff) Then
		        Return outBuff.WString(0)
		      End If
		    End If
		    Return RelativePath
		  #endif
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetEndOfFile Lib "Kernel32" (hFile As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetFilePointer Lib "Kernel32" (hFile As Integer, DistanceToMove As Integer, DistanceToMoveHigh As Ptr, MoveMethod As Integer) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function Tokenize(Input As String) As String()
		  #If TargetWin32 Then
		    Dim ret() As String
		    Dim cmdLine As String = Input
		    While cmdLine.Len > 0
		      Dim tmp As String
		      Dim args As String = PathGetArgs(cmdLine)
		      If Len(args) = 0 Then
		        tmp = ReplaceAll(cmdLine.Trim, Chr(34), "")
		        ret.Append(tmp)
		        Exit While
		      Else
		        tmp = Left(cmdLine, cmdLine.Len - args.Len).Trim
		        tmp = ReplaceAll(tmp, Chr(34), "")
		        ret.Append(tmp)
		        cmdLine = args
		      End If
		    Wend
		    Return ret
		  #endif
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function WriteFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToWrite As Integer, ByRef BytesWritten As Integer, Overlapped As Ptr) As Boolean
	#tag EndExternalMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or &h1FF
			End Get
		#tag EndGetter
		FILE_ALL_ACCESS As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return STANDARD_RIGHTS_READ Or FILE_READ_DATA Or FILE_READ_ATTRIBUTES Or FILE_READ_EA Or SYNCHRONIZE
			End Get
		#tag EndGetter
		FILE_GENERIC_READ As Integer
	#tag EndComputedProperty


	#tag Constant, Name = CREATE_NEW, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ADD_FILE, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ADD_SUBDIRECTORY, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_APPEND_DATA, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_ARCHIVE, Type = Double, Dynamic = False, Default = \"&h20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_COMPRESSED, Type = Double, Dynamic = False, Default = \"&h800", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_DEVICE, Type = Double, Dynamic = False, Default = \"&h40", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_DIRECTORY, Type = Double, Dynamic = False, Default = \"&h10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_ENCRYPTED, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_HIDDEN, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_INTEGRITY_STREAM, Type = Double, Dynamic = False, Default = \"&h8000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NOT_CONTENT_INDEXED, Type = Double, Dynamic = False, Default = \"&h2000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NO_SCRUB_DATA, Type = Double, Dynamic = False, Default = \"&h20000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_OFFLINE, Type = Double, Dynamic = False, Default = \"&h1000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_READONLY, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_REPARSE_POINT, Type = Double, Dynamic = False, Default = \"&h400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_SPARSE_FILE, Type = Double, Dynamic = False, Default = \"&h200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_SYSTEM, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_TEMPORARY, Type = Double, Dynamic = False, Default = \"&h100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_VIRTUAL, Type = Double, Dynamic = False, Default = \"&h10000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_BEGIN, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_CASE_PRESERVED_NAMES, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_CASE_SENSITIVE_SEARCH, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_CREATE_PIPE_INSTANCE, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_CURRENT, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_DELETE_CHILD, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_DEVICE_MASS_STORAGE, Type = Double, Dynamic = False, Default = \"&h0000002d", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_END, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_EXECUTE, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FILE_COMPRESSION, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_DELETE_ON_CLOSE, Type = Double, Dynamic = False, Default = \"&h04000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_FIRST_PIPE_INSTANCE, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_RANDOM_ACCESS, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_SEQUENTIAL_SCAN, Type = Double, Dynamic = False, Default = \"&h08000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_LIST_DIRECTORY, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NAMED_STREAMS, Type = Double, Dynamic = False, Default = \"&h00040000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_NORMALIZED, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_OPENED, Type = Double, Dynamic = False, Default = \"&h8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_DIR_NAME, Type = Double, Dynamic = False, Default = \"&h00000002\r", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_FILE_NAME, Type = Double, Dynamic = False, Default = \"&h00000001\r", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_LAST_WRITE, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_SECURITY, Type = Double, Dynamic = False, Default = \"&h00000100\r", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_SIZE, Type = Double, Dynamic = False, Default = \"&h00000008\r", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_PERSISTENT_ACLS, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ACCESS, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_DATA, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_EA, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ONLY_VOLUME, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SEQUENTIAL_WRITE_ONCE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_DELETE, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_READ, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_WRITE, Type = Double, Dynamic = False, Default = \"&h2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_ENCRYPTION, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_EXTENDED_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h00800000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_HARD_LINKS, Type = Double, Dynamic = False, Default = \"&h00400000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_OBJECT_IDS, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_OPEN_BY_FILE_ID, Type = Double, Dynamic = False, Default = \"&h01000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_REPARSE_POINTS, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_SPARSE_FILES, Type = Double, Dynamic = False, Default = \"&h00000040", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_TRANSACTIONS, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_USN_JOURNAL, Type = Double, Dynamic = False, Default = \"&h02000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_TRAVERSE, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_UNICODE_ON_DISK, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_VOLUME_IS_COMPRESSED, Type = Double, Dynamic = False, Default = \"&h00008000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_VOLUME_QUOTAS, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h0100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_DATA, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_EA, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_MESSAGE_FROM_SYSTEM, Type = Double, Dynamic = False, Default = \"&H1000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_ALL, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_READ, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GENERIC_WRITE, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INVALID_HANDLE_VALUE, Type = Double, Dynamic = False, Default = \"&hffffffff", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INVALID_SET_FILE_POINTER, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_PATH, Type = Double, Dynamic = False, Default = \"260", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_COPY_ALLOWED, Type = Double, Dynamic = False, Default = \"&h2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_CREATE_HARDLINK, Type = Double, Dynamic = False, Default = \"&h10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_DELAY_UNTIL_REBOOT, Type = Double, Dynamic = False, Default = \"&h4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_FAIL_IF_NOT_TRACKABLE, Type = Double, Dynamic = False, Default = \"&h20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_REPLACE_EXISTING, Type = Double, Dynamic = False, Default = \"&h1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"&h8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OPEN_ALWAYS, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
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

	#tag Constant, Name = REPLACEFILE_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SPECIFIC_RIGHTS_ALL, Type = Double, Dynamic = False, Default = \"&h0000FFFF", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_ALL, Type = Double, Dynamic = False, Default = \"&h001F0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_EXECUTE, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_READ, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_REQUIRED, Type = Double, Dynamic = False, Default = \"&h000F0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_WRITE, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SYNCHRONIZE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRUNCATE_EXISTING, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = IO_STATUS_BLOCK, Flags = &h1
		Status As Int32
		Info As Int32
	#tag EndStructure

	#tag Structure, Name = SECURITY_ATTRIBUTES, Flags = &h1
		Length As Integer
		  secDescriptor As Ptr
		InheritHandle As Boolean
	#tag EndStructure

	#tag Structure, Name = WIN32_FIND_STREAM_DATA, Flags = &h1
		StreamSize As Int64
		StreamName As String*1024
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="FILE_ALL_ACCESS"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FILE_GENERIC_READ"
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
