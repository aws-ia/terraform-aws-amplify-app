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

  repository                     = "your-existing-repo-url"
  lookup_ssm_github_access_token = true
  ssm_github_access_token_name   = "Enter-Your-SSM-Parameter-Store-Key"

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
