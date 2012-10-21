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
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Write"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   81
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   68
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Read"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   81
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   102
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin TextArea TextArea1
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   100
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   200
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   49
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   200
   End
   Begin PushButton PushButton3
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Read"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   75
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   218
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  'Dim s As Win32.IOStream
		  'Dim f As FolderItem = GetFolderItem("C:\Users\Andrew\Desktop\test.txt")
		  's = Win32.IOStream.Create(f, Win32.CREATE_NEW)
		  'If s.LastError = 0 Then
		  'For i As Integer = 0 To 100
		  's.Write("Hello, world! " + Str(i))
		  'Next
		  'Dim i As Integer = s.Length
		  's.Length = s.Length * 2
		  's.Position = 0
		  'Dim y As String = s.Read(i)
		  's.Close
		  'Break
		  'Else
		  'Break
		  'End If
		  
		  'Dim start1, start2, end1, end2, time1, time2 As UInt64
		  '
		  'start1 = Microseconds
		  'Dim f As New FolderItem
		  'end1 = Microseconds
		  '
		  'start2 = Microseconds
		  'Dim g As New Win32File.FileInstance("C:\WINDOWS\..\")
		  'end2 = Microseconds
		  '
		  'time1 = end1 - start1
		  'time2 = end2 - start2
		  'Quit
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim p As Win32.IOStream = Win32.IOStream.CreateNamedPipe("BSTEST", Win32.PIPE_ACCESS_OUTBOUND)
		  p.Write("Hello, world!")
		  p.Flush
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Dim p As Win32.IOStream = Win32.IOStream.CreateNamedPipe("BSTEST", Win32.PIPE_ACCESS_INBOUND)
		  Dim s As String = p.Read(32)
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton3
	#tag Event
		Sub Action()
		  Dim p As Win32.FileItem = Win32.IOStream.CreateFileItem("L:\Videos\Cara Minecraft—the Turret Opera in Minecraft (Note Blocks).flv", Win32.OPEN_EXISTING, Win32.GENERIC_READ, Win32.FILE_SHARE_READ Or Win32.FILE_SHARE_WRITE Or Win32.FILE_SHARE_DELETE, 0)
		  If p.Exists Then
		    Break
		  Else
		    Break
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
