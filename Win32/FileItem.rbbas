#tag Class
Protected Class FileItem
Inherits Win32.IOStream
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim mb As New MemoryBlock(MAX_PATH)
			  Dim l As Integer = GetFinalPathNameByHandle(Me.Handle, mb, mb.Size, 0)
			  If l > mb.Size Then
			    mb = New MemoryBlock(l)
			    l = GetFinalPathNameByHandle(Me.Handle, mb, mb.Size, 0)
			  End If
			  
			  Return mb.WString(0)
			End Get
		#tag EndGetter
		AbsolutePath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Me.Handle > 0
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="Handle"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="Win32.IOStream"
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
			InheritedFrom="Win32.IOStream"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastError1"
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
			Name="Length"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="Win32.IOStream"
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
			InheritedFrom="Win32.IOStream"
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
