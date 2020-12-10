resource "vault_mount" "kv" {
  path        = "secret"
  type        = "kv"
  description = "secrets engine mount"
}