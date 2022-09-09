# tf-azurerm-module-mssql_server

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module will provision a MS SQL database server and an optional extended audit policy. This module depends on the below mentioned resources which must be existing at the time of creation of this module. 
- Resource Group
- Storage Account (for extended audit policy)

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# Terradocs
Below are the details that are generated by Terradocs plugin. It contains information about the module, inputs, outputs etc.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.21.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_firewall_rule.firewall_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.server_auditing_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Target Resource Group where all the infrastructure for this module will be created | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | <pre>{<br>  "location": "eastus",<br>  "name": "deb-test-devops"<br>}</pre> | no |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | Name of the Microsoft SQL server name | `string` | n/a | yes |
| <a name="input_sql_server_version"></a> [sql\_server\_version](#input\_sql\_server\_version) | Version of the Microsoft SQL server | `string` | `"12.0"` | no |
| <a name="input_administrator_login_username"></a> [administrator\_login\_username](#input\_administrator\_login\_username) | The admin username for the server | `string` | n/a | yes |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The admin password for the server | `string` | n/a | yes |
| <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy) | The connection policy for the server. Possible values are Default, Proxy or Redirect | `string` | `"Default"` | no |
| <a name="input_enable_system_managed_identity"></a> [enable\_system\_managed\_identity](#input\_enable\_system\_managed\_identity) | Should the system managed identity be enabled for SQL Server? | `bool` | `true` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | Minimum TLS version for the server. Default is 1.2. Possible values are 1.0, 1.1, 1.2 or Disabled | `string` | `"1.2"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for this server? Defaults to true | `bool` | `true` | no |
| <a name="input_outbound_network_restriction_enabled"></a> [outbound\_network\_restriction\_enabled](#input\_outbound\_network\_restriction\_enabled) | Whether outbound network traffic is restricted for this server. Defaults to false | `bool` | `false` | no |
| <a name="input_extended_auditing_enabled"></a> [extended\_auditing\_enabled](#input\_extended\_auditing\_enabled) | Whether the extended auditing should be enabled? | `bool` | `false` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain the logs in the storage account | `number` | `30` | no |
| <a name="input_storage_endpoint"></a> [storage\_endpoint](#input\_storage\_endpoint) | The blob storage that will hold the extended auditing logs | `string` | `""` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | The access key of the storage account | `string` | `""` | no |
| <a name="input_allowAccessToAzureServices"></a> [allowAccessToAzureServices](#input\_allowAccessToAzureServices) | If true, it enables all the azure services to access the database server. | `bool` | `true` | no |
| <a name="input_allowFirewallIpList"></a> [allowFirewallIpList](#input\_allowFirewallIpList) | A list of IP Address to whitelist, in order to access the database server | `list(string)` | `[]` | no |
| <a name="input_allowFirewallIpRangesList"></a> [allowFirewallIpRangesList](#input\_allowFirewallIpRangesList) | A list of IP Address ranges to whitelist, in order to access the database server | <pre>list(object({<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `[]` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | A map of custom tags to be attached to this SQL Server instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sql_server_id"></a> [sql\_server\_id](#output\_sql\_server\_id) | ID of the MS Sql Server |
| <a name="output_sql_server_fqdn"></a> [sql\_server\_fqdn](#output\_sql\_server\_fqdn) | FQDN of the MS Sql Server |
| <a name="output_name"></a> [name](#output\_name) | Name of the MS Sql Server |
| <a name="output_admin_login_username"></a> [admin\_login\_username](#output\_admin\_login\_username) | Admin Login Username of the MS Sql Server |
| <a name="output_admin_login_password"></a> [admin\_login\_password](#output\_admin\_login\_password) | Admin Login Password of the MS Sql Server |
| <a name="output_restorable_dropped_database_ids"></a> [restorable\_dropped\_database\_ids](#output\_restorable\_dropped\_database\_ids) | A list of dropped restorable database IDs on this server |
| <a name="output_identity_pricipal_id"></a> [identity\_pricipal\_id](#output\_identity\_pricipal\_id) | System Assigned Identity Principal ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
