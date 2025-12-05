@echo off
REM
REM This batch file is used to uninstall Password protected Netskope Client from SCCM
REM
SetLocal
for /f "tokens=2 delims==" %%f in ('wmic product where "Name like 'Netskope Client'" get IdentifyingNumber /value ^| find "="') do set "productCode=%%f"
IF DEFINED productCode (    
     msiexec /uninstall %productCode% PASSWORD="Qazplm123" /qn /l*v %PUBLIC%nscuninstall.log   
     ) ELSE (    
REM Did not find product code for Netskope Client
)
EndLocal
