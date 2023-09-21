################################################################################
# App
################################################################################

resource "aws_amplify_app" "this" {
  name       = var.name
  repository = var.create_codecommit_repo ? aws_codecommit_repository.this[0].clone_url_http : var.repository

  # Auto Branch
  enable_auto_branch_creation   = var.enable_auto_branch_creation
  enable_branch_auto_deletion   = var.enable_auto_branch_deletion
  auto_branch_creation_patterns = var.auto_branch_creation_patterns

  auto_branch_creation_config {
    enable_auto_build           = var.enable_auto_build
    enable_pull_request_preview = var.enable_pull_request_preview
    enable_performance_mode     = var.enable_performance_mode
    framework                   = var.framework
  }

  iam_service_role_arn = var.create_codecommit_repo ? aws_iam_role.amplify_codecommit[0].arn : var.iam_service_role_arn
  access_token         = var.access_token
  build_spec           = var.build_spec

  dynamic "custom_rule" {
    for_each = length(var.custom_rules) > 0 ? var.custom_rules : {}

    content {
      source = lookup(custom_rule.value, "source", "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>")
      status = lookup(custom_rule.value, "status", "200")
      target = lookup(custom_rule.value, "target", "/index.html")
    }
  }

  environment_variables = var.environment_variables

  tags = var.tags
}

################################################################################
# Branch(es)
################################################################################

resource "aws_amplify_branch" "this" {
  for_each = var.branches

  app_id                = aws_amplify_app.this.id
  branch_name           = lookup(each.value, "branch_name", null)
  framework             = lookup(each.value, "framework", null)
  stage                 = lookup(each.value, "stage", null)
  environment_variables = lookup(each.value, "environment_variables", null)
}

################################################################################
# Domain Association
################################################################################

resource "aws_amplify_domain_association" "this" {
  count = var.create_domain_association ? 1 : 0

  wait_for_verification = var.wait_for_verification
  app_id                = aws_amplify_app.this.id
  domain_name           = var.domain_name

  dynamic "sub_domain" {
    for_each = var.sub_domains

    content {
      branch_name = lookup(sub_domain.value, "branch_name", null)
      prefix      = lookup(sub_domain.value, "prefix", null)
    }
  }

  depends_on = [aws_amplify_branch.this]
}

################################################################################
# CodeCommit Repository
################################################################################

resource "aws_codecommit_repository" "this" {
  count = var.create_codecommit_repo ? 1 : 0

  repository_name = var.codecommit_repo_name != null ? var.codecommit_repo_name : "codecommit-repo"
  description     = var.codecommit_repo_description
  default_branch  = var.codecommit_repo_default_branch

  tags = var.tags
}

data "aws_iam_policy_document" "amplify_codecommit" {
  count = var.create_codecommit_repo ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "amplify_codecommit" {
  count = var.create_codecommit_repo ? 1 : 0

  name                = "${var.amplify_codecommit_role_name}-${var.name}"
  assume_role_policy  = data.aws_iam_policy_document.amplify_codecommit[0].json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"]
}

################################################################################
# GitLab Mirror IAM User
################################################################################

resource "aws_iam_user" "gitlab_mirror" {
  count = var.create_codecommit_repo && var.create_gitlab_mirror_iam_user ? 1 : 0

  name          = var.gitlab_mirror_iam_user_name != null ? var.gitlab_mirror_iam_user_name : "gitlab-mirror"
  path          = "/${var.name}/"
  force_destroy = true

  tags = var.tags
}

resource "aws_iam_user_policy" "gitlab_mirror_policy" {
  count = var.create_codecommit_repo && var.create_gitlab_mirror_iam_user ? 1 : 0

  name = var.gitlab_mirror_policy_name
  user = aws_iam_user.gitlab_mirror[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "codecommit:GitPull",
        "codecommit:GitPush",
      ]
      Effect = "Allow"
      Resource = [
        aws_codecommit_repository.this[0].arn
      ]
    }]
  })
}
