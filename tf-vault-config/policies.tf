resource "vault_policy" "example" {
  name = "is-team"

  policy = <<EOT
path "secret/sshastri/gift" {
  capabilities = ["create", "update"]
}

path "secret/sshastri/address" {
  capabilities = ["create", "update"]
}

EOT
}