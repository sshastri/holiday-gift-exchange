# Grinch Holiday Gift Exchange   ❄️ ☃️ 🎁 🍻 ❄️

OK - you are here! You have selected your gift(s) online. What do you do now?
![whos](./img/whoville.jpg)

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

## Web Instructions (for username/password)

1. Go to https://grinch.is.very-serious.business:8200

2. Login using username/pass

3. Under Secret Engines, click on secret

4. This will put you on a page that says "Not Authorized" 
IN THE BROWSER URL BAR, add your username to the URL and hit enter
For example: http://localhost:8200/ui/vault/secrets/secret/list => http://localhost:8200/ui/vault/secrets/secret/list/sshastri

5. There should be two keys listed (address and gift)
![step5](./img/step5.png)

6. Click into each key (address and gift) and hit `Edit Secret` in the top right side. Update and save the values. For example, the gift key looks like:
![step6](./img/step6.png)

7. Logout. Congratulations you are done!


