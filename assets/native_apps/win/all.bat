@echo off
wmic /Append:STDOUT cpu get Name /Value <nul
wmic /Append:STDOUT PATH Win32_VideoController get Name,DriverVersion /Value <nul
wmic /Append:STDOUT OS get Version,TotalVisibleMemorySize /Value <nul