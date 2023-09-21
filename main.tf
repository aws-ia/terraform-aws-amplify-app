resource "aws_amplify_app" "this" {
  name       = var.app_name
  repository = var.create_codecommit_repo ? aws_codecommit_repository.this[0].clone_url_http : var.existing_repo_url

  # Auto Branch
  enable_auto_branch_creation   = var.enable_auto_branch_creation
  enable_branch_auto_deletion   = var.enable_auto_branch_deletion
  auto_branch_creation_patterns = var.auto_branch_creation_patterns

  auto_branch_creation_config {
    enable_auto_build           = var.enable_auto_build
    enable_pull_request_preview = var.enable_app_pr_preview
    enable_performance_mode     = var.enable_performance_mode
    framework                   = var.app_framework
  }

  iam_service_role_arn = var.create_codecommit_repo ? aws_iam_role.amplify_codecommit[0].arn : null
  access_token         = var.lookup_ssm_github_access_token ? data.aws_ssm_parameter.ssm_github_access_token[0].value : var.github_access_token
  build_spec           = var.path_to_build_spec != null ? var.path_to_build_spec : var.build_spec

  dynamic "custom_rule" {
    for_each = length(var.custom_rewrite_and_redirect) > 0 ? var.custom_rewrite_and_redirect : {}

    content {
      source = lookup(custom_rule.value, "source", "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>")
      status = lookup(custom_rule.value, "status", "200")
      target = lookup(custom_rule.value, "target", "/index.html")
    }
  }

  environment_variables = var.environment_variables
}

resource "aws_amplify_branch" "this" {
  for_each = var.manual_branches

  app_id                = aws_amplify_app.this.id
  branch_name           = lookup(each.value, "branch_name", null)
  framework             = lookup(each.value, "framework", null)
  stage                 = lookup(each.value, "stage", null)
  environment_variables = lookup(each.value, "environment_variables", null)
}

resource "aws_amplify_domain_association" "this" {
  count = var.create_domain_associations ? 1 : 0

  wait_for_verification = var.wait_for_verification
  app_id                = aws_amplify_app.this.id
  domain_name           = var.domain_name

  dynamic "sub_domain" {
    for_each = var.domain_associations

    content {
      branch_name = lookup(sub_domain.value, "branch_name", null)
      prefix      = lookup(sub_domain.value, "prefix", null)
    }
  }

  depends_on = [aws_amplify_branch.this]
}
