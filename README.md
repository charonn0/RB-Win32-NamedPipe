RB-Win32-NamedPipe
==================

A RB BinaryStream-backed interface to Win32 Named Pipes

Use Win32.CreateNamedPipe to create a new named pipe server. 

Use Win32.ConnectNamedPipe to connect as a client to a previously created named pipe server.

Both functions return a RB BinaryStream. 

Not yet finished:
*Asynchronous server creation.