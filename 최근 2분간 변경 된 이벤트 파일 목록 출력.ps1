$Loglist = Get-WinEvent -ListLog *


$Before = (Get-Date) - (New-TimeSpan -Minute 2)
$Current = Get-Date


foreach ($filename in $Loglist) {
    #$filename
    $RecentModified = $filename | Where-Object {$_.LastWriteTime -gt $Before -and $_.LastWriteTime -lt $Current}
    $RecentModified.LogName
    $RecentModified.LastWriteTime
}
