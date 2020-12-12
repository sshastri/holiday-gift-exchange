resource "vault_policy" "is-team" {
  name = "is-team"

  policy = <<EOT
  
  path "secret/{{identity.entity.aliases.auth_github_485791de.name}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_github_485791de.name}}/gift" {
    capabilities = ["create", "update", "read"]
    required_parameters = ["description", "url"]
  }

  path "secret/{{identity.entity.aliases.auth_github_485791de.name}}/address" {
    capabilities = ["create", "update"]
    required_parameters = ["address"]
  }

EOT
}