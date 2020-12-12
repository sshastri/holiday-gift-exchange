resource "vault_policy" "is-team" {
  name = "is-team"

  policy = <<EOT
  
  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.metadata.username}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.metadata.username}}/gift" {
    capabilities = ["create", "update"]
    required_parameters = ["description, url"]
  }

  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.metadata.username}}/address" {
    capabilities = ["create", "update"]
    required_parameters = ["address"]
  }

EOT
}