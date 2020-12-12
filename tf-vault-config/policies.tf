resource "vault_policy" "is-team" {
  name = "is-team"

  policy = <<EOT
  
  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.name}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.name}}/gift" {
    capabilities = ["create", "update", "read"]
    required_parameters = ["description", "url"]
  }

  path "secret/{{identity.entity.aliases.auth_github_d70a61ae.name}}/address" {
    capabilities = ["create", "update"]
    required_parameters = ["address"]
  }

EOT
}

resource "vault_policy" "userpass" {
  name = "userpass"

  policy = <<EOT

  path "secret/{{identity.entity.aliases.auth_userpass_4569cfc6.name}}/*" {
    capabilities = ["list"]
  }

  path "secret/{{identity.entity.aliases.auth_userpass_4569cfc6.name}}/gift" {
    capabilities = ["create", "update", "read", "list"]
  }

  path "secret/{{identity.entity.aliases.auth_userpass_4569cfc6.name}}/address" {
    capabilities = ["create", "update", "read", "list"]
  }

EOT
}