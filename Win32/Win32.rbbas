#tag Module
Protected Module Win32
	#tag ExternalMethod, Flags = &h0
		Declare Function CloseHandle Lib "Kernel32" (handle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CreateFile Lib "Kernel32" Alias "CreateFileW" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function FlushFileBuffers Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function GetLastError Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function LockFile Lib "Kernel32" (FileHandle As Integer, dwFileOffsetLow As Integer, dwFileOffsetHigh As Integer, nNumberOfBytesToLockLow As Integer, nNumberOfBytesToLockHigh As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function ReadFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToRead As Integer, ByRef BytesRead As Integer, Overlapped As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function SetEndOfFile Lib "Kernel32" (hFile As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function SetFilePointer Lib "Kernel32" (hFile As Integer, DistanceToMove As Integer, DistanceToMoveHigh As Ptr, MoveMethod As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function WriteFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToWrite As Integer, ByRef BytesWritten As Integer, Overlapped As Ptr) As Boolean
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


	#tag Constant, Name = CREATE_NEW, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ADD_FILE, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ADD_SUBDIRECTORY, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_APPEND_DATA, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_ARCHIVE, Type = Double, Dynamic = False, Default = \"&h20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_COMPRESSED, Type = Double, Dynamic = False, Default = \"&h800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_DEVICE, Type = Double, Dynamic = False, Default = \"&h40", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_DIRECTORY, Type = Double, Dynamic = False, Default = \"&h10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_ENCRYPTED, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_HIDDEN, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_INTEGRITY_STREAM, Type = Double, Dynamic = False, Default = \"&h8000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NORMAL, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NOT_CONTENT_INDEXED, Type = Double, Dynamic = False, Default = \"&h2000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_NO_SCRUB_DATA, Type = Double, Dynamic = False, Default = \"&h20000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_OFFLINE, Type = Double, Dynamic = False, Default = \"&h1000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_READONLY, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_REPARSE_POINT, Type = Double, Dynamic = False, Default = \"&h400", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_SPARSE_FILE, Type = Double, Dynamic = False, Default = \"&h200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_SYSTEM, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_TEMPORARY, Type = Double, Dynamic = False, Default = \"&h100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_ATTRIBUTE_VIRTUAL, Type = Double, Dynamic = False, Default = \"&h10000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_BEGIN, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_CASE_PRESERVED_NAMES, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_CASE_SENSITIVE_SEARCH, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_CREATE_PIPE_INSTANCE, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_CURRENT, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_DELETE_CHILD, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_DEVICE_MASS_STORAGE, Type = Double, Dynamic = False, Default = \"&h0000002d", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_END, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_EXECUTE, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_FILE_COMPRESSION, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_DELETE_ON_CLOSE, Type = Double, Dynamic = False, Default = \"&h04000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_RANDOM_ACCESS, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_SEQUENTIAL_SCAN, Type = Double, Dynamic = False, Default = \"&h08000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_FLAG_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_LIST_DIRECTORY, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAMED_STREAMS, Type = Double, Dynamic = False, Default = \"&h00040000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_NORMALIZED, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_OPENED, Type = Double, Dynamic = False, Default = \"&h8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_DIR_NAME, Type = Double, Dynamic = False, Default = \"&h00000002\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_FILE_NAME, Type = Double, Dynamic = False, Default = \"&h00000001\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_LAST_WRITE, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_SECURITY, Type = Double, Dynamic = False, Default = \"&h00000100\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOTIFY_CHANGE_SIZE, Type = Double, Dynamic = False, Default = \"&h00000008\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_PERSISTENT_ACLS, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ACCESS, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_DATA, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_EA, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ONLY_VOLUME, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SEQUENTIAL_WRITE_ONCE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_DELETE, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_READ, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_WRITE, Type = Double, Dynamic = False, Default = \"&h2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_ENCRYPTION, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_EXTENDED_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h00800000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_HARD_LINKS, Type = Double, Dynamic = False, Default = \"&h00400000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_OBJECT_IDS, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_OPEN_BY_FILE_ID, Type = Double, Dynamic = False, Default = \"&h01000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_REPARSE_POINTS, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_SPARSE_FILES, Type = Double, Dynamic = False, Default = \"&h00000040", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_TRANSACTIONS, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SUPPORTS_USN_JOURNAL, Type = Double, Dynamic = False, Default = \"&h02000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_TRAVERSE, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_UNICODE_ON_DISK, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_VOLUME_IS_COMPRESSED, Type = Double, Dynamic = False, Default = \"&h00008000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_VOLUME_QUOTAS, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h0100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_DATA, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_WRITE_EA, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FORMAT_MESSAGE_FROM_SYSTEM, Type = Double, Dynamic = False, Default = \"&H1000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GENERIC_ALL, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GENERIC_READ, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GENERIC_WRITE, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INVALID_HANDLE_VALUE, Type = Double, Dynamic = False, Default = \"&hffffffff", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INVALID_SET_FILE_POINTER, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAX_PATH, Type = Double, Dynamic = False, Default = \"260", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_COPY_ALLOWED, Type = Double, Dynamic = False, Default = \"&h2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_CREATE_HARDLINK, Type = Double, Dynamic = False, Default = \"&h10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_DELAY_UNTIL_REBOOT, Type = Double, Dynamic = False, Default = \"&h4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_FAIL_IF_NOT_TRACKABLE, Type = Double, Dynamic = False, Default = \"&h20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_REPLACE_EXISTING, Type = Double, Dynamic = False, Default = \"&h1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"&h8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OPEN_ALWAYS, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OPEN_EXISTING, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = REPLACEFILE_WRITE_THROUGH, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SPECIFIC_RIGHTS_ALL, Type = Double, Dynamic = False, Default = \"&h0000FFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_ALL, Type = Double, Dynamic = False, Default = \"&h001F0000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_EXECUTE, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_READ, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_REQUIRED, Type = Double, Dynamic = False, Default = \"&h000F0000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_WRITE, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SYNCHRONIZE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TRUNCATE_EXISTING, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant


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
