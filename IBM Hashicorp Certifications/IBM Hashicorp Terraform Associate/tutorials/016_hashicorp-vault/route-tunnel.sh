#!/bin/bash
set -e

TUNNEL_NAME=${1:-"vault-tunnel"}
HOSTNAME=${2:-"vault.daviddtessier.ca"}

echo "=== Cloudflare Tunnel DNS Routing ==="
echo "Routing tunnel '$TUNNEL_NAME' to '$HOSTNAME'..."

# Create the DNS record routing the hostname to the tunnel
cloudflared tunnel route dns "$TUNNEL_NAME" "$HOSTNAME"

echo
echo "=========================================================="
echo "Successfully created DNS route!"
echo "You should now be able to access Vault at:"
echo "https://$HOSTNAME"
echo "=========================================================="
