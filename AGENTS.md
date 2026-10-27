# Agent Instructions for UFC Mania Project

## Automatic Git Push Workflow
Whenever the user asks to push changes to Git or GitHub (e.g. "push to git", "git push kardo", "repo me daal do", "push changes", "update git"):
- **DO NOT ask the user to open a terminal or run commands.**
- **DO NOT ask the user for a token or password.**
- Run the automated push script located in the project root:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "git_push.ps1" -Message "<descriptive message of what changed>"
  ```
- The script automatically handles:
  1. Staging all modified/untracked files (`git add -A`)
  2. Committing with the descriptive message
  3. Seamlessly retrieving the user's permanent GitHub session from Windows Credential Manager (`git-credential-wincred.exe`) and pushing to `origin/main`
  4. Updating local tracking refs
- Confirm to the user when push is completed with the commit summary.
