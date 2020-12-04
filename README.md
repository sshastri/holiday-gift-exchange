# holiday-gift-exchange
Project to facilitate The Great Ninja Gift Exchange of 2020

## The Premise

The Anti White Elephant Gift Exchange (where we gift each other COOL things)

1. Everyone gets $35 to select a gift/gifts that they would want for themselves (**but don't actually purchase the gift**)
  - Some Guidelines:
    - The items(s) must be available to be ordered online, save the link to the item(s)
    - Gift cards are not allowed - this creates trouble with finance
2. We get together as a team and perform a "white elephant" where you "virtually unwrap" a new gift or steal from previously opened gift 
(technically we are stealing URLS from each other, not physical gifts)
3. The gifts get tracked on a sheet. At the end of the session, I'll order the gifts to be sent to people and expense the results.



## Setup
- Vault server
- Config & Policies
- Website - dashboard

## Process

### Inserting Gifts

- Team authenticates to Vault using Github ID (todo - check if Jason, Ash and PM's have github ids. If not, give them a username/pw)

- Policy only allows for write/update to:
  - `secrets/gifts/githubid`
  - `secrets/address/githubid`

### Retrieving  Gifts

- Not sure what to do here
- vault login, `token -num_uses` ...?


## Instructions for team members:

### CLI:
```
export VAULT_ADDR=<vault address>
vault login -method=github 
vault write secrets/gifts/<githubid> gift1=some_url gift2=some_other_url
```

### WEB UI:

Pointy clicky something

## Website/Dashboard:


NINJA TEAM HOLIDAY GIFT EXCHANGE 2020 - DASHBOARD

| People - (order to pick gift) 	| Gifts to pick from 	| Gift available for steal  | Locked              |
|-------------------------------	|--------------------	|---------------------------|--------------------	|
| Austin                        	| arodd              	| https://www.amazon...     | https://www.am..	  |
| Johnny                        	| krary              	| https://www.amazon.com    |                     | 
| Kyle                          	| aileenmk           	| https://www.amazon.com/d	|                     |                                                                     	|
| Shobs                         	|                    	|                           |                    	|

## TO-DO LIST
- Terraform code for deploying Vault (cheap, public facing, on a cool domain)
- Terraform code for deploying webserver/app/dashboard? <-- not sure route here
- Terraform Vault provider configuration for auth method/secret engine/policy creation
- Instructions for CLI
- Instructions for Web UI







