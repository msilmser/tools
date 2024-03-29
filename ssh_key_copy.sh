#!/bin/bash

# Function to copy the SSH public key to a single host
copy_ssh_key() {
    local host=$1
    echo "Copying SSH public key to $host..."
    ssh-copy-id $host
}

# Check for at least one host argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 host1 [host2 ...]"
    exit 1
fi

# Check for existing SSH keys
echo "Checking for existing SSH keys..."
if [ -f "$HOME/.ssh/id_rsa" ]; then
    echo "An SSH key already exists. Skipping key generation..."
else
    # Generate a new SSH key pair
    echo "Generating a new SSH key..."
    ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N "" <<<y >/dev/null 2>&1
    echo "SSH key generated."
fi

# Loop through each host provided as an argument
for host in "$@"; do
    copy_ssh_key $host
done

echo "Done. You should now be able to SSH to the hosts without a password."
