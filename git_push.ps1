param(
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"
$git = "C:\Users\yash sharma\AppData\Local\Programs\MinGit\cmd\git.exe"
$wincred = "C:\Users\yash sharma\AppData\Local\Programs\MinGit\ucrt64\libexec\git-core\git-credential-wincred.exe"

# If no message provided, generate default with timestamp
if ([string]::IsNullOrWhiteSpace($Message)) {
    $Message = "Update UFC Mania website - " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
}

# Stage all changes
& $git add -A

# Check if there is anything to commit
$status = & $git status --porcelain
if ($status) {
    & $git commit -m $Message
    Write-Host "Committed: $Message"
} else {
    Write-Host "No new changes to commit (already up to date locally)."
}

# Fetch credentials from Windows Credential Manager
$raw = "protocol=https`nhost=github.com" | & $wincred get
$dict = @{}
$raw | ForEach-Object { if ($_ -match '^([^=]+)=(.*)$') { $dict[$matches[1]] = $matches[2] } }
$u = $dict['username']
$p = $dict['password']

if ($u -and $p) {
    Write-Host "Pushing to GitHub (origin/main)..."
    & $git push "https://${u}:${p}@github.com/yashsharma359/UFC-mania-test.git" main
    & $git fetch "https://${u}:${p}@github.com/yashsharma359/UFC-mania-test.git" main:refs/remotes/origin/main
    Write-Host "SUCCESS: Repository pushed and synced with GitHub!"
} else {
    Write-Error "Could not retrieve GitHub credentials from Windows Credential Manager."
}
