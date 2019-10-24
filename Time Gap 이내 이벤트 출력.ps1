$Logfiles= Get-WinEvent -ListLog *

$Before = (Get-Date) - (New-TimeSpan -Second 30)

'Before'
$Before

foreach($Logfile in $Logfiles){
    if($Logfile.RecordCount -gt 0){
        $Logname = $Logfile.LogName                              # Log file name
        <# if($LogName -eq "Security" -or $Logname -eq "System"){
                continue
        } #>       
        Write-Host -NoNewline "Current : " 
        $Logname

        $LogContents= Get-WinEvent -LogName $LogName -MaxEvents 100
        
        if($LogContents.Length -gt 0){
            
            # Replace backslash included in event file name with %4
            $Logname = $Logname -replace "/", "%4"
            Write-Host -NoNewline 'Filename : '
            $LogName
            $LogContents | Export-Csv -NoTypeInformation -Path "C:\Users\dfrc\Desktop\Logfile Dir\$Logname.csv" -Append -Encoding UTF8
        }    
    }
}

