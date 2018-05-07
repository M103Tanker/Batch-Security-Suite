Set oSystems = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true")
For Each oSystem in oSystems
   'LOGOFF   = 0
   'SHUTDOWN = 1
   'REBOOT   = 2
   'FORCE    = 4
   'POWEROFF = 8
   oSystem.Win32Shutdown 1
Next