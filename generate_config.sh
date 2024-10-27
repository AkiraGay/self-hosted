#!/usr/bin/env bash

# hostnames
echo "" >> Revolt.toml
echo "[hosts]" >> Revolt.toml
echo "app = \"https://$1\"" >> Revolt.toml
echo "api = \"https://$1/api\"" >> Revolt.toml
echo "events = \"wss://$1/ws\"" >> Revolt.toml
echo "autumn = \"https://$1/autumn\"" >> Revolt.toml
echo "january = \"https://$1/january\"" >> Revolt.toml

# VAPID keys
echo "" >> Revolt.toml
echo "[api.vapid]" >> Revolt.toml
openssl ecparam -name prime256v1 -genkey -noout -out vapid_private.pem
echo "private_key = \"$(base64 vapid_private.pem)\"" >> Revolt.toml
echo "public_key = \"$(openssl ec -in vapid_private.pem -outform DER|tail -c 65|base64|tr '/+' '_-'|tr -d '\n')\"" >> Revolt.toml

# encryption key for files
echo "" >> Revolt.toml
echo "[files]" >> Revolt.toml
echo "encryption_key = \"$(openssl rand -base64 32)\"" >> Revolt.toml
