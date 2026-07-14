#!/bin/bash
# Script to generate self-signed certificates for Vault internal TLS
set -e

CERT_DIR="./vault-config/certs"
mkdir -p "$CERT_DIR"

echo "Generating self-signed certificate for Vault..."

openssl req -x509 -newkey rsa:4096 \
  -keyout "$CERT_DIR/vault.key" \
  -out "$CERT_DIR/vault.crt" \
  -days 365 -nodes \
  -subj "/CN=vaultapp.local.daviddtessier.ca"

chmod 644 "$CERT_DIR/vault.key" "$CERT_DIR/vault.crt"

echo "Certificates generated in $CERT_DIR"
