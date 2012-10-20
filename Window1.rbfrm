#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1334323199
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim s As Win32.FileStream
		  Dim f As FolderItem = GetFolderItem("C:\Users\Andrew\Desktop\test.txt")
		  s = Win32.FileStream.Create(f, CREATE_NEW)
		  If s.LastError = 0 Then
		    For i As Integer = 0 To 100
		      s.Write("Hello, world! " + Str(i))
		    Next
		    Dim i As Integer = s.Length
		    s.Length = s.Length * 2
		    s.Position = 0
		    Dim y As String = s.Read(i)
		    s.Close
		    Break
		  Else
		    Break
		  End If
		End Sub
	#tag EndEvent


#tag EndWindowCode

