# Wait for the agent to be ready
Start-Sleep -s 5
# Load the No-PIN key
& "C:\Program Files\OpenSSH\ssh-add.exe" "$HOME\.ssh\id_ed25519_sk_nopin"
