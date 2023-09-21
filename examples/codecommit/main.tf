provider "aws" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "us-west-2"

  tags = {
    Example = local.name
  }
}

################################################################################
# Amplify App Module
################################################################################

module "amplify_app" {
  source = "../../"

  name = local.name

  build_spec = file("buildspec.yaml")
  environment_variables = {
    EXAMPLE = "hello"
  }

  create_codecommit_repo = true

  # Auto-branch management
  enable_auto_branch_creation   = true
  enable_auto_branch_deletion   = true
  auto_branch_creation_patterns = ["main"]
  enable_auto_build             = true
  enable_pull_request_preview   = true

  # Custom domain
  create_domain_association = true
  domain_name               = "yourdomain.com"
  sub_domains = {
    bare = {
      branch_name = "main"
      prefix      = ""
    },
    www = {
      branch_name = "main"
      prefix      = "www"
    },
    dev = {
      branch_name = "dev"
      prefix      = "dev"
    }
  }

  custom_rules = {
    static_site = {
      source = "/<*>"
      status = "404"
      target = "/index.html"
    },
  }

  tags = local.tags
}
