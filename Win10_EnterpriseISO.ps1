# Author         Dillon Cain
# Date           10/30/2020
# About          Downloads latest Windows 10 media creation tool located in C:\WinTemp then opens the tool in Enterprise mode to retrieve the latest ISO.

# Checks for admin privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# Declared variables
$Folder = "C:\WinTemp"
$mediaCreationToolUrl = "http://go.microsoft.com/fwlink/?LinkId=691209"
$mediaCreationToolExe = "C:\WinTemp\MediaCreationTool.exe"
$webClient = New-Object System.Net.WebClient

# Create WinTemp folder on C:

If(!(test-path $Folder))
{
New-Item -ItemType Directory -Force -Path $Folder
Write-Host 'Temp folder WinTemp created'
Start-Sleep -Seconds .5
}

# Downloads and saves Win10 media creation tool to C:\WinTemp

$webClient.DownloadFile($mediaCreationToolUrl, $mediaCreationToolExe)
(New-Object System.Net.WebClient).DownloadFile($mediaCreationToolUrl, $mediaCreationToolExe)
Write-Host ".....Media Creation Tool downloaded"
Start-Sleep -Seconds 2

# Path to media creation tool
Write-Host "___________________________________"
Write-Host ".....Starting media creation tool"
Start-Sleep -Seconds 2
Set-Location C:\WinTemp
# Opens Enteprise version of Windows 10 tool
.\MediaCreationTool.exe /Eula Accept /Retail /MediaArch x64 /MediaLangCode en-US /MediaEdition Enterprise