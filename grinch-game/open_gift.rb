#!/usr/bin/ruby

require 'vault'

#Vault.address = "https://grinch.is.very-serious.business:8200" # Also reads from ENV["VAULT_ADDR"]
#Vault.token   = "XXXX" # Also reads from ENV["VAULT_TOKEN"]

#open_gift player_name gift_username

secret = Vault.logical.list("grinchexchange/")


# Read from the secret/ mount, write to the grinchexchange/ mount 
secret.each do |user|
    
    puts user
    
    # gift = Vault.logical.read("secret/"+ user +"/gift")
    # 
    # path = "grinchexchange/" + name
    # 
    # Vault.logical.write(path, url: gift.data[:url],
    #   description: gift.data[:description],
    #   opened: false,
    #   owner: "",
    #   steals: 0
    # )
end

