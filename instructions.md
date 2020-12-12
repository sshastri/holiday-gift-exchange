# Grinch Holiday Gift Exchange   ❄️ ☃️ 🎁 🍻 ❄️

OK - you are here! You have selected your gift(s) online. What do you do now?
![whos](https://lh3.googleusercontent.com/proxy/fFXcT7YB1t5X6L68cscPT2zSf7u07cpxQ-WKLDQEw4TY7id_zqSUmna6V3xNhoQD6-KY-4cgYzmpAClaxp4JwB7GXZA0uYfJFw)

## Prerequisites
- github account OR username/password provided by Culture Czar
- url of gift(s) (comma separated)
- description of gift(s) 
- shipping address
- credit card details and SSN (just kidding...)

Example Key Value Entry:

url="http://hellokitty.com/socks, http://hellokitty.com/shoes" description="Hello Kitty Socks and Shoes"


## Command Line Instructons (for github authentication)

1. Authenticate to Vault using your github token

```bash
export $VAULT_ADDR=https://grinch.is.very-serious.business:8200
vault login -method=github
GitHub Personal Access Token (will be hidden):

```

2. Insert Gift to Vault (PLEASE READ CAREFULLY, automation depends on correct key/value combo)

```
vault kv put secret/<github_id>/gift \
url="http://hellokitty.com/socks, http://hellokitty.com/shoes" \
description="Hello Kitty Socks and Shoes"
```

3. Enter your shipping address

```
vault kv put secret/<github_id>/address \
address="1600 Pennsylvania Ave., Washington, D.C., 20500, USA"
```

## Web Instructions

1. Go to https://grinch.is.very-serious.business:8200

2. Login using github or username/pass

3. https://grinch.is.very-serious.business:8200/ui/vault/secrets/secret/list/sshastri/
