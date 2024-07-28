# backup configuration
$ExeName = "restic.exe"
$InstallPath = "C:\restic"
$ResticExe = Join-Path $InstallPath $ExeName
$StateFile = Join-Path $InstallPath "state.xml"
$WindowsExcludeFile = Join-Path $InstallPath "windows.exclude"
$LocalExcludeFile = Join-Path $InstallPath "local.exclude"
$LogPath = Join-Path $InstallPath "logs"
$LogRetentionDays = 30
$InternetTestAttempts = 0
$GlobalRetryAttempts = 4
$IgnoreMissingBackupSources = $false
$AdditionalBackupParameters = @("--exclude-if-present", ".nobackup")

# maintenance configuration
$SnapshotMaintenanceEnabled = $true
$SnapshotRetentionPolicy = @("--group-by", "host,tags", "--keep-daily", "30", "--keep-weekly", "52", "--keep-monthly", "24", "--keep-yearly", "10")
$SnapshotPrunePolicy = @("--max-unused", "1%")
$SnapshotMaintenanceInterval = 7
$SnapshotMaintenanceDays = 30
$SnapshotDeepMaintenanceDays = 90

# email configuration
$SendEmailOnSuccess = $false
$SendEmailOnError = $false

# Paths to backup
$BackupSources = @{}
$BackupSources["C:\"] = @(
    'Users\chris'
)
$BackupSources["D:\"] = @(
    'workspace',
    'Mikrotik'
)
#$BackupSources["DRIVE_LABEL_NAME_OR_SERIAL_NUMBER"] = @(
#    'FolderName'
#)

function configureArborUpdateTool {
    $SN_WriteConfig = Get-IniContent("C:\amobile\Android11_Tools\SNWrite_wifi\SN_Setup_imei1.ini")
    $SN_WriteConfig["System Setup"]["AP database path"] = $updateToolInstallDirectory + "\" + $global:_apdbRelativePath
    Out-IniFile -InputObject $SN_WriteConfig -FilePath "C:\amobile\Android11_Tools\SNWrite_wifi\SN_Setup_imei1.ini" -Force -Encoding ASCII
    Copy-Item -Path ".\history.ini " -Destination $global:updateToolInstallDirectory\Flash_Tool\history.ini -Force
}

