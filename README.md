<!-- BEGIN_TF_DOCS -->
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

# Basic Usage - CodeCommit Repo with Automatic Branch Creation

```hcl
// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "sample-qs" {
  // location of the module - can be local or git repo
  source = "novekm/amplify-app/aws"

  app_name = "my-app"
  create_codecommit_repo = true
  lookup_existing_codecommit_repo = false
  // see /examples for sample_build_spec
  path_to_build_spec = "/path/to/your/build/spec/file"

  // Auto Branch Creation
  enable_auto_branch_creation   = true
  enable_auto_branch_deletion   = true
  auto_branch_creation_patterns = ["main"]
  enable_auto_build             = true
  enable_app_pr_preview   = true
  app_framework                     = "Something bloated and hard to maintain"

  // - Custom Domain -
  create_domain_associations = false
  domain_name                = "yourdomain.com"
  domain_associations = {
    core = {
      branch_name = "main"
      prefix      = ""
    },
    www = {
      branch_name = "main"
      prefix      = "www"
    },
  }

  custom_rewrite_and_redirect = {
    // Static website rewrite/redirect
    static_site = {
      source = "/<*>"
      status = "404"
      target = "/index.html"
    },
    // Rewrite/redirect for single page apps - default if you don't specify anything else
    # single_page_app = {
    #   source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
    #   status = "200"
    #   target = "/index.html"
    # },
    // Rewrite/redirect for `yourdomain.com/app2` to `yourotherdomain.com`
    # app2 = {
    #   source = "/app2"
    #   status = "302"
    #   target = "https://yourotherdomain.com"
    # },
  }
}
```

# Examples

- [CodeCommit Repo with Auto Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/codecommit-deployment/auto-branch-creation/main.tf)
- [CodeCommit Repo with Manual Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/codecommit-deployment/manual-branch-creation/main.tf)
- [GitHub Repo with Auto Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/github-deployment/auto-branch-creation/main.tf)
- [GitHub Repo with Manual Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/github-deployment/auto-branch-creation/main.tf)
- [GitLab Repo with Auto Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/gitlab-deployment/auto-branch-creation/main.tf)
- [GitLab Repo with Manual Branch Creation](https://github.com/aws-ia/terraform-aws-amplify-app/blob/main/examples/gitlab-deployment/auto-branch-creation/main.tf)

# Contributing

See the `CONTRIBUTING.md` file for information on how to contribute.

# Workshop

For more information, check out my workshop [**Automating Deployment of AWS Amplify Apps with Terraform**](https://catalog.workshops.aws/amplify-with-terraform/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0, < 5.0.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.sample_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.manual](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_domain_association.amplify_domain_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association) | resource |
| [aws_codecommit_repository.codecommit_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_iam_role.amplify_codecommit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_user.gitlab_mirroring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.gitlab_mirroring_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_codecommit_repository.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository) | data source |
| [aws_iam_policy_document.amplify_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.ssm_github_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amplify_app_arn"></a> [amplify\_app\_arn](#output\_amplify\_app\_arn) | The ARN for the Amplify App |
| <a name="output_amplify_app_default_domain"></a> [amplify\_app\_default\_domain](#output\_amplify\_app\_default\_domain) | The default domain for the Amplify App |
| <a name="output_amplify_app_id"></a> [amplify\_app\_id](#output\_amplify\_app\_id) | The App ID for the Amplify App |
| <a name="output_amplify_app_production_branch"></a> [amplify\_app\_production\_branch](#output\_amplify\_app\_production\_branch) | The production branch for the Amplify App |
| <a name="output_amplify_app_tags_all"></a> [amplify\_app\_tags\_all](#output\_amplify\_app\_tags\_all) | All tags for the Amplify App |
| <a name="output_aws_current_region"></a> [aws\_current\_region](#output\_aws\_current\_region) | AWS Current Region |
<!-- END_TF_DOCS -->
