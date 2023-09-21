# CodeCommit Deployment

This deployment path can be used if you wish to use an AWS CodeCommit repo with your Amplify App.

The module can either create a CodeCommit repo and necessary permissions to allow Amplify to access it for you, or you can specify your own CodeCommit repo that already has this configuration.

**IMPORTANT** When using manual branches, if you add additional domain associations beyond what was defined when you first ran `terraform apply`, this will force resource replacement of the Amplify App. The resource will be deleted and recreated, which can lead to downtime. For that reason, it is recommended to use the Auto Branch Creation. That deployment path will not force a resource replacement as long as [**Performance Mode**](https://docs.aws.amazon.com/amplify/latest/userguide/ttl.html) is set to `false` (not enabled). This is the default value for that reason.

The easiest way to push to a CodeCommit Repo is by using [**git-remote-codecommit**](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html). Visit the link [**here**](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html) for installation instructions.

## Add files to CodeCommit Repo

1. In the top level directory for your code, run `git init` to initialize the directory as a git repo. If you need to redo this step, or have the repo connected to another remote repo that you wish to unlink, run `rm -rf .git` if you need to redo this step, or have the repo connected to another remote repo that you wish to unlink.
2. Connect your local git repo to the remote git repo with `git remote add origin code:commit::<your-aws-region>//<your-repo-name>`. Ex. `git remote add origin code:commit::us-east-1//codecommit_repo`
3. Change default master branch to 'main' with `git branch -M main`
4. Stage all your files with `git add .`
5. Commit your files with `git commit -m "some descriptive message"`
6. Set the upstream to the 'main' branch in your remote repo with `git push -u origin main`
7. Head to the AWS Amplify console and you should see your main branch building.
8. Repeat this for any additional branches you wish to add. Remember for additional branches to auto-build, you must add them to the `auto_branch_creation_patterns`.

## Add your Custom Domain

At this point you can add a custom domain.

1. In `main.tf` set your `domain_name` and also set `create_domain_associations` to true. Also ensure in `domain_associations` you are referencing branches that you actually see in the Amplify Console.
2. Re-apply the terraform code with `terraform apply`
3. Head to the Amplify Console and click `Domain management`. If using a domain managed by Route53, you should automatically see the SSL domain being generated and associated for you.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_amplify_app"></a> [amplify\_app](#module\_amplify\_app) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

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
