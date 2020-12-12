#vault write auth/github/config organization=hashicorp 
resource "vault_github_auth_backend" "config" {
  organization = "hashicorp"
}

# vault write auth/github/map/teams/team-is value=is-team
resource "vault_github_team" "tf_devs" {
  backend  = vault_github_auth_backend.config.id
  team     = "team-is"
  policies = ["is-team"]
}
