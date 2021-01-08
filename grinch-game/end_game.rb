#!/usr/bin/ruby

require 'vault'

#Vault.address = "https://grinch.is.very-serious.business:8200" # Also reads from ENV["VAULT_ADDR"]
#Vault.token   = "XXXX" # Also reads from ENV["VAULT_TOKEN"]

#Delete the secret mount 
#vault secrets disable grinchexchange
Vault.sys.unmount("grinchexchange")
