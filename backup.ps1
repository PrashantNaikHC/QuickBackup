#getting current date
$today = Get-Date -UFormat "%Y-%m-%d"
$time = Get-Date -UFormat "%H:%M"

#target directory for the backup
$targetDirPath="C:\Users\userName\Desktop\myWorkingDirectory"

#directory where the backup files should be placed
$backupDir="E:\"

$backupDirPath = $backupDir+$today

#log file
$logPath = "C:\Users\userName\Desktop\log.txt"
$dash="-------------------------------------------------------------------"

Add-Content $logPath $dash
Add-Content $logPath "$today $time - Starting Backup"
Add-Content $logPath "$today $time - Below files have been modified since last 24 Hrs"

robocopy $targetDirPath $backupDirPath /e /xf *.*
foreach ($f in Get-ChildItem $targetDirPath -recurse -file)
{
    if ($f.LastWriteTime -gt ($(Get-Date).AddDays(-1)))
    {
    Copy-Item $f.FullName -Destination $backupDirPath$($f.Fullname.Substring($targetDirPath.length))
	Add-Content $logPath "$today $time - Backup of the file $f has been taken"
    }
}
Add-Content $logPath "$today $time - Backup is complete"
Add-Content $logPath $dash
Write-Host "Backup is complete"
