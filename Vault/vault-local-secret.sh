#!/bin/bash

# vault server -dev

# http://localhost:8200/ui/

# export VAULT_ADDR='http://127.0.0.1:8200'
# vault server -config=/etc/vault/config.hcl
# vault kv put secret/foo @data.json
# echo "abcd1234" | vault kv put secret/foo bar=-

cat > vault-server.hcl <<EOF
disable_mlock = true
ui            = true

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = "true"
}

storage "file" {
  path = "/vault-data"
}
EOF

vault server -config vault-server.hcl -log-level=err -dev-root-token-id="root" &

# vault server -dev -dev-root-token-id="root" &

# sleep 1

# export VAULT_ADDR='http://127.0.0.1:8200'
# export VAULT_TOKEN="root"
 
vault kv put secret/test/api/secret client_secret=abc123
vault kv put secret/test/api/vender_key access_token=xyz456

sleep 2

vault kv get secret/test/api/secret

wait
