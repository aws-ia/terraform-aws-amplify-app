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

  repository   = var.repository
  access_token = var.access_token

  # Note: branches specified must already exist in the connected repository
  branches = {
    main = {
      branch_name = "main"
      framework   = "None"
      stage       = "PRODUCTION"
      environment_variables = {
        Key1 = "Value1"
        Key2 = "Value2"
      }
    },
    dev = {
      branch_name = "dev"
      framework   = "React"
      stage       = "DEVELOPMENT"
      environment_variables = {
        Key1 = "Value1"
        Key2 = "Value2"
      }
    },
  }

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
