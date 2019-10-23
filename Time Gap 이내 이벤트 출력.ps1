$Logfiles= Get-WinEvent -ListLog *

$Current = Get-Date
$Before = (Get-Date) - (New-TimeSpan -Second 30)

'Time Gap'
$Current
$Before

foreach($Logfile in $Logfiles){
    if($Logfile.RecordCount -gt 0){
        
        $Result = Get-WinEvent -LogName $Logfile.LogName | Where {$_.TimeCreated -ge $Before -And $_.TimeCreated -le $Current} |
                  Select -Propert 'TimeCreated', 'Id'
        $Logname = $Logfile.LogName
        Write-Host -NoNewline "Current : " 
        $Logname
        if($Result){
            $Logname = $Logname -replace "/", "%4"
            Write-Host -NoNewline 'Filename : ' $Logname
            $Result | Export-Csv -Path "C:\Users\dfrc\Desktop\Logfile Dir\$Logname.csv"
        }    
    }
}