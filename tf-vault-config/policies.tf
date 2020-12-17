#todo - don't hardcode the mount path

resource "vault_policy" "is-team" {
  name = "is-team"

  policy = <<EOT
  
  path "secret/{{identity.entity.aliases.auth_github_ce4bbd87.name}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_github_ce4bbd87.name}}/gift" {
    capabilities = ["create", "update", "read"]
    required_parameters = ["description", "url"]
  }

  path "secret/{{identity.entity.aliases.auth_github_ce4bbd87.name}}/address" {
    capabilities = ["create", "update"]
    required_parameters = ["address"]
  }

EOT
}

resource "vault_policy" "userpass" {
  name = "userpass"

  policy = <<EOT

  path "secret/{{identity.entity.aliases.auth_userpass_5a40b6d5.name}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_userpass_5a40b6d5.name}}/gift" {
    capabilities = ["create", "update", "read", "list"]
  }

  path "secret/{{identity.entity.aliases.auth_userpass_5a40b6d5.name}}/address" {
    capabilities = ["create", "update", "read", "list"]
  }

EOT
}