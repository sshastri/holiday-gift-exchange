#!/bin/bash

#Quick and dirty script to enable userpass for users without github and/or are not 
#part of the github org
#Make sure VAULT_ADDR is set and authenticated to vault as privileged user

#Enable the userpass auth method
vault auth enable userpass


users=(jason stephanie jess dana giota)

# populate these passwords with something
password=DUMMYPASSWORD

for u in "${users[@]}"
do
  vault write auth/userpass/users/$u \
      password=$password \
      policies=is-team

  echo "Created userpass auth for $u"
done
