#!/usr/bin/ruby

require 'vault'

#Vault.address = "https://grinch.is.very-serious.business:8200" # Also reads from ENV["VAULT_ADDR"]
#Vault.token   = "XXXX" # Also reads from ENV["VAULT_TOKEN"]

#Create a secret mount 
#vault secrets enable -path=grinchexchange kv
#Vault.sys.mount( "grinchexchange", "kv", "grinch gifts", options: {})

secret = Vault.logical.list("secret/")

puts secret

#Read from the secret/ mount, write to the grinchexchange/ mount 
secret.each do |user|
    name = user.chomp!("/")

    gift = Vault.logical.read("secret/"+ user +"/gift")

    path = "grinchexchange/" + name

    puts user 
   
    
    Vault.logical.write(path, url: gift.data[:url],
      description: gift.data[:description],
      opened: false,
      owner: "",
      steals: 0
    )

    puts

end
