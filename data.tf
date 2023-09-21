data "aws_ssm_parameter" "ssm_github_access_token" {
  count = var.lookup_ssm_github_access_token ? 1 : 0

  name = var.ssm_github_access_token_name
}
