#!/bin/bash
set -e

TUNNEL_NAME=${1:-"vault-tunnel"}

echo "=== Cloudflare Persistent Tunnel Setup for Vault ==="

# Check if user is logged in
echo "Checking cloudflared authentication..."
if ! cloudflared tunnel list >/dev/null 2>&1; then
    echo "Authentication required. Opening browser to login to Cloudflare..."
    cloudflared tunnel login
fi

echo "Creating persistent tunnel named: $TUNNEL_NAME"
cloudflared tunnel create "$TUNNEL_NAME"

echo
echo "=========================================================="
echo "Tunnel '$TUNNEL_NAME' has been successfully created!"
echo "Next steps:"
echo "1. Route a DNS hostname to this tunnel:"
echo "   cloudflared tunnel route dns $TUNNEL_NAME vault.yourdomain.com"
echo ""
echo "2. Get your tunnel token from the Cloudflare Zero Trust Dashboard,"
echo "   or run the Cloudflare tunnel with credentials file."
echo ""
echo "3. Update your .env file with the TUNNEL_TOKEN if using docker-compose."
echo "   (Note: docker-compose.yml uses CF_TUNNEL_TOKEN so ensure your .env matches!)"
echo "=========================================================="
