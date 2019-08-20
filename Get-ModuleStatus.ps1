function Get-ModuleStatus {
 [CmdletBinding()]

    param(
        [Parameter(Mandatory = $false)]
        [string] $VerbosePreference = 'Continue',
        
        [Parameter(Mandatory = $false)]
        [string]$LogFileName = 'Get-ModuleStatus.txt',

        [Parameter(Mandatory = $false)]
        [string]$LogFileDirectory = 'C:\Users\' + $env:username + '\Documents\PSLogs',
        
        [Parameter(Mandatory = $false)]
        [string]$Date = (Get-Date),

        [Parameter(Mandatory = $True)]
        [string]$ModuleName

        )

    begin {
        if ((Test-Path $LogFileDirectory -ErrorAction Ignore) -ne $True) {
            New-Item -Path ('C:\Users\' + $env:username + '\Documents') -Name PSLogs -ItemType Directory
            Write-Verbose "Created PSLogs Folder."
            }
        else {
            Write-Verbose "$LogFileDirectory already exists."
            }
        }

    process {
        Start-Transcript -Path $LogFileDirectory\$LogFileName -Append
        Write-Verbose "------ $date run of script beginning... ------"   
        if (!(Get-InstalledModule $ModuleName -ErrorAction Ignore)) {
            Write-Verbose "$ModuleName is not installed on $env:COMPUTERNAME. Would you like to proceed with installation?"
            Install-Module -Name $ModuleName -AllowClobber -Force -Confirm
            Write-Verbose "$ModuleName has been installed on $env:COMPUTERNAME. Proceeding..."
            }
        else {
            "$ModuleName is installed and up-to-date on $env:COMPUTERNAME. Proceeding..."
            }
        }
    end {
        Write-Verbose "Checking install status..."
        Get-InstalledModule $ModuleName
        Write-Verbose "------ $date run of script ended. ------"
        Stop-Transcript
        }
}