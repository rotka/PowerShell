# log file
# Start Transcript of PowerShell Session
Start-Transcript -Path '.\transcript.txt' -Append


# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")


#  Get Users&Groups

$location = Get-Location
$users = Get-LocalUser -Name * | Export-Csv "$location\users.csv"
$groups = Get-LocalGroup -Name * | Export-Csv "$location\groups.csv"

# Get Network Settings
$route = route print | Out-File "$location\route.txt"
$ip = ipconfig /all | Export-Csv "$location\ip.csv"


# Get Firewall rules
$fw = Get-NetFirewallSetting | Export-Csv "$location\fw.csv"
$ports = Get-NetFirewallPortFilter | ft | Export-Csv "$location\ports.csv"


# Process

$process = Get-Process | Export-Csv "$location\process.csv"

# HARDWARE
$cpuinfo = Get-WmiObject Win32_Processor | Export-Csv "$location\cpu.csv"
$osinfo = Get-WmiObject Win32_OperatingSystem | Export-Csv "$location\os.csv"
$meminfo = Get-WmiObject CIM_PhysicalMemory | Export-Csv "$location\memory.csv"
