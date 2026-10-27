# Automated Git Push Workflow

Whenever the USER requests to push changes to Git / GitHub (e.g., "git push kardo", "push to repo", "push it to git", "commit and push"):

1. **Always use the automated push script**:
   Execute the following command directly via `run_command`:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "c:\Users\yash sharma\Desktop\ufc maina\git_push.ps1" -Message "<Descriptive commit message>"
   ```
2. **Never ask the user to open terminal or provide a token**:
   The script automatically reads the authenticated credentials already present in Windows Credential Manager (`git-credential-wincred.exe`) and pushes seamlessly.
3. **Confirm completion to user**:
   Report the commit message and confirm that the changes are live on `origin/main`.
