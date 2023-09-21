# Features

- Conditional and Dynamic Resource Creation
- Automatic and Manual Branch Creation Support
- Automatic and Manual Branch Deletion Support
- Automatic Build for Branches Support
- Customizable Automatic Branch Creation Patterns Support
- Pull Request Previews Support
- CodeCommit, GitHub, GitLab support with examples
- **Related workshop for deeper explanation**
  - [**Automated Deployment of AWS Amplify Apps with Terraform**](https://catalog.workshops.aws/amplify-with-terraform/)

## Basic Usage - CodeCommit Repo with Automatic Branch Creation

```hcl
module "amplify-app" {
  source = "aws-ia/amplify-app/aws"

  name                   = "example"
  create_codecommit_repo = true
  build_spec             = file("buildspec.yml")

  # Auto-branch creation
  enable_auto_branch_creation   = true
  enable_auto_branch_deletion   = true
  auto_branch_creation_patterns = ["main"]
  enable_auto_build             = true
  enable_pull_request_preview   = true

  # Custom domain
  create_domain_association = true
  domain_name               = "yourdomain.com"
  sub_domains = {
    core = {
      branch_name = "main"
      prefix      = ""
    },
    www = {
      branch_name = "main"
      prefix      = "www"
    },
  }

  custom_rules = {
    static_site = {
      source = "/<*>"
      status = "404"
      target = "/index.html"
    },
  }
}
```

## Examples

- [CodeCommit Repo with Manual Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/codecommit)
- [GitHub Repo with Auto Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/github)

## Contributing

See the `CONTRIBUTING.md` file for information on how to contribute.

## Workshop

For more information, check out my workshop [**Automating Deployment of AWS Amplify Apps with Terraform**](https://catalog.workshops.aws/amplify-with-terraform/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association) | resource |
| [aws_codecommit_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_iam_role.amplify_codecommit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_user.gitlab_mirror](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.gitlab_mirror_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_policy_document.amplify_codecommit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.ssm_github_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | Optional GitHub access token. Only required if using GitHub repo. | `string` | `null` | no |
| <a name="input_amplify_codecommit_role_name"></a> [amplify\_codecommit\_role\_name](#input\_amplify\_codecommit\_role\_name) | Name for the role Amplify will use to access the CodeCommit repo | `string` | `"amplify-codecommit"` | no |
| <a name="input_auto_branch_creation_patterns"></a> [auto\_branch\_creation\_patterns](#input\_auto\_branch\_creation\_patterns) | Automated branch creation glob patterns for the Amplify app. Ex. feat*/* | `list(any)` | <pre>[<br>  "main"<br>]</pre> | no |
| <a name="input_branches"></a> [branches](#input\_branches) | Map of branch definitions to be created | `map(any)` | `{}` | no |
| <a name="input_build_spec"></a> [build\_spec](#input\_build\_spec) | The actual content of your build\_spec. Use if 'path\_to\_build\_spec' is not defined. | `string` | `null` | no |
| <a name="input_codecommit_repo_default_branch"></a> [codecommit\_repo\_default\_branch](#input\_codecommit\_repo\_default\_branch) | The default branch for the CodeCommit repo | `string` | `"main"` | no |
| <a name="input_codecommit_repo_description"></a> [codecommit\_repo\_description](#input\_codecommit\_repo\_description) | The description for the CodeCommit repo | `string` | `"The CodeCommit repo created during the Terraform deployment"` | no |
| <a name="input_codecommit_repo_name"></a> [codecommit\_repo\_name](#input\_codecommit\_repo\_name) | CodeCommit repo name | `string` | `"codecommit_repo"` | no |
| <a name="input_create_codecommit_repo"></a> [create\_codecommit\_repo](#input\_create\_codecommit\_repo) | Conditional creation of CodeCommit repo | `bool` | `false` | no |
| <a name="input_create_domain_association"></a> [create\_domain\_association](#input\_create\_domain\_association) | Enables default association of your domain with the 'main' branch of the Amplify App. | `bool` | `false` | no |
| <a name="input_create_gitlab_mirror_iam_user"></a> [create\_gitlab\_mirror\_iam\_user](#input\_create\_gitlab\_mirror\_iam\_user) | Enables GitLab mirror to the option AWS CodeCommit repo. | `bool` | `false` | no |
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | Custom rewrites and redirects for the domain associations. | `map(any)` | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of your domain. Ex. naruto.ninja | `string` | `"example.com"` | no |
| <a name="input_enable_auto_branch_creation"></a> [enable\_auto\_branch\_creation](#input\_enable\_auto\_branch\_creation) | Enables automated branch creation for the Amplify app. | `bool` | `false` | no |
| <a name="input_enable_auto_branch_deletion"></a> [enable\_auto\_branch\_deletion](#input\_enable\_auto\_branch\_deletion) | Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository. | `bool` | `false` | no |
| <a name="input_enable_auto_build"></a> [enable\_auto\_build](#input\_enable\_auto\_build) | Enables auto-building of autocreated branches for the Amplify App. | `bool` | `false` | no |
| <a name="input_enable_performance_mode"></a> [enable\_performance\_mode](#input\_enable\_performance\_mode) | Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes. | `bool` | `false` | no |
| <a name="input_enable_pull_request_preview"></a> [enable\_pull\_request\_preview](#input\_enable\_pull\_request\_preview) | Enables pull request previews for the autocreated branch. | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Global environment variables for your Amplify App. These will only appear in the AWS Management Console if a git repo is connected. | `map(string)` | `null` | no |
| <a name="input_framework"></a> [framework](#input\_framework) | Framework for the autocreated branch. | `string` | `null` | no |
| <a name="input_gitlab_mirror_iam_user_name"></a> [gitlab\_mirror\_iam\_user\_name](#input\_gitlab\_mirror\_iam\_user\_name) | The IAM Username for the GitLab mirror IAM User. | `string` | `null` | no |
| <a name="input_gitlab_mirror_policy_name"></a> [gitlab\_mirror\_policy\_name](#input\_gitlab\_mirror\_policy\_name) | The name of the IAM policy attached to the GitLab mirror IAM User | `string` | `"gitlab_mirror_policy"` | no |
| <a name="input_lookup_ssm_github_access_token"></a> [lookup\_ssm\_github\_access\_token](#input\_lookup\_ssm\_github\_access\_token) | *IMPORTANT!*<br>Conditional data fetch of SSM parameter store for GitHub access token.<br>To ensure security of this token, you must manually add it via the AWS console<br>before using. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Sample Amplify Application. | `string` | `"sample-amplify-app"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | URL for the existing repo. | `string` | `null` | no |
| <a name="input_ssm_github_access_token_name"></a> [ssm\_github\_access\_token\_name](#input\_ssm\_github\_access\_token\_name) | The name (key) of the SSM parameter store of your GitHub access token | `string` | `null` | no |
| <a name="input_sub_domains"></a> [sub\_domains](#input\_sub\_domains) | The domains/subdomains you wish to associate with the Amplify App. These are mapped to git branches. | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(any)` | `{}` | no |
| <a name="input_wait_for_verification"></a> [wait\_for\_verification](#input\_wait\_for\_verification) | If set to 'true', the resource will wait for the domain association status to change to 'PENDING\_DEPLOYMENT' or 'AVAILABLE'. Setting this to false will skip the process. Default is set to 'false'. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Amplify app |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | Default domain for the Amplify app |
| <a name="output_domain_association_arn"></a> [domain\_association\_arn](#output\_domain\_association\_arn) | ARN of the Amplify domain association |
| <a name="output_domain_association_certificate_verification_dns_record"></a> [domain\_association\_certificate\_verification\_dns\_record](#output\_domain\_association\_certificate\_verification\_dns\_record) | The DNS record for certificate verification |
| <a name="output_id"></a> [id](#output\_id) | Unique ID of the Amplify app |
| <a name="output_production_branch"></a> [production\_branch](#output\_production\_branch) | Describes the information about a production branch for an Amplify app |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
