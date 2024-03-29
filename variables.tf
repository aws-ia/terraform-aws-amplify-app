# - Amplify -
variable "app_name" {
  type        = string
  default     = "sample-amplify-app"
  description = "The name of the Sample Amplify Application."
}
variable "path_to_build_spec" {
  type        = string
  default     = null
  description = "The path to the location of your build_spec file. Use if 'build_spec' is not defined."

}
variable "build_spec" {
  type        = string
  default     = null
  description = "The actual content of your build_spec. Use if 'path_to_build_spec' is not defined."
}
variable "environment_variables" {
  type        = map(string)
  default     = null
  description = "Global environment variables for your Amplify App. These will only appear in the AWS Management Console if a git repo is connected."

}
variable "manual_branches" {
  type        = map(any)
  default     = {}
  description = "List of manual branches you wish to create."

}
variable "enable_auto_branch_creation" {
  type        = bool
  default     = false
  description = "Enables automated branch creation for the Amplify app."

}
variable "enable_auto_branch_deletion" {
  type        = bool
  default     = false
  description = "Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository."

}
variable "auto_branch_creation_patterns" {
  type        = list(any)
  default     = ["main", ]
  description = "Automated branch creation glob patterns for the Amplify app. Ex. feat*/*"

}
variable "enable_auto_build" {
  type        = bool
  default     = false
  description = "Enables auto-building of autocreated branches for the Amplify App."

}
variable "enable_app_pr_preview" {
  type        = bool
  default     = false
  description = "Enables pull request previews for the autocreated branch."

}
variable "enable_performance_mode" {
  type        = bool
  default     = false
  description = "Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes."
}
variable "app_framework" {
  type        = string
  default     = null
  description = "Framework for the autocreated branch."

}
variable "existing_repo_url" {
  type        = string
  default     = null
  description = "URL for the existing repo."

}
variable "github_access_token" {
  type        = string
  default     = null
  description = "Optional GitHub access token. Only required if using GitHub repo."

}
variable "create_domain_associations" {
  type        = bool
  default     = false
  description = "Enables default association of your domain with the 'main' branch of the Amplify App."
}
variable "domain_name" {
  type        = string
  default     = "example.com"
  description = "The name of your domain. Ex. naruto.ninja"
}
variable "domain_associations" {
  type        = map(any)
  default     = {}
  description = "The domains/subdomains you wish to associate with the Amplify App. These are mapped to git branches."

}
variable "wait_for_verification" {
  type        = bool
  default     = false
  description = "If set to 'true', the resource will wait for the domain association status to change to 'PENDING_DEPLOYMENT' or 'AVAILABLE'. Setting this to false will skip the process. Default is set to 'false'."

}
variable "custom_rewrite_and_redirect" {
  type        = map(any)
  default     = {}
  description = "Custom rewrites and redirects for the domain associations."

}
variable "app_tags" {
  type        = map(string)
  default     = null
  description = "Tags for your Amplify App."

}


# - Route53 - ** Not currently used **
# variable "create_route53_hosted_zone" {
#   type        = bool
#   default     = false
#   description = "Conditional creation of Route53 hosted zone"

# }

# variable "sub_domain_route53_records" {
#   type    = map(any)
#   default = {}
# }
# variable "lookup_existing_route53_zone" {
#   type = bool
#   default = false
#   description = "Conditional fetch of existing Route53 hosted zone"
# }



# - CodeCommit -
variable "create_codecommit_repo" {
  type        = bool
  default     = false
  description = "Conditional creation of CodeCommit repo"
}
variable "codecommit_repo_name" {
  type        = string
  default     = "codecommit_repo"
  description = "CodeCommit repo name"
}
variable "codecommit_repo_description" {
  type        = string
  default     = "The CodeCommit repo created during the Terraform deployment"
  description = "The description for the CodeCommit repo"
}
variable "codecommit_repo_default_branch" {
  type        = string
  default     = "main"
  description = "The default branch for the CodeCommit repo"
}
variable "lookup_existing_codecommit_repo" {
  type        = bool
  default     = false
  description = "Conditional fetch of existing CodeCommit repo"

}
variable "existing_codecommit_repo_name" {
  type        = string
  default     = null
  description = "Name of existing CodeCommit repo"

}
variable "amplify_codecommit_role_name" {
  type        = string
  default     = "amplify-codecommit"
  description = "Name for the role Amplify will use to access the CodeCommit repo"

}


# - GitHub -
variable "lookup_ssm_github_access_token" {
  type        = bool
  default     = false
  description = <<-EOF
  *IMPORTANT!*
  Conditional data fetch of SSM parameter store for GitHub access token.
  To ensure security of this token, you must manually add it via the AWS console
  before using.
  EOF

}
variable "ssm_github_access_token_name" {
  type        = string
  default     = null
  description = "The name (key) of the SSM parameter store of your GitHub access token"

}


# - GitLab -
variable "enable_gitlab_mirroring" {
  type        = bool
  default     = false
  description = "Enables GitLab mirroring to the option AWS CodeCommit repo."
}
variable "gitlab_mirroring_iam_user_name" {
  type    = string
  default = null
  # default     = "gitlab_mirroring"
  description = "The IAM Username for the GitLab Mirroring IAM User."
}
variable "gitlab_mirroring_policy_name" {
  type        = string
  default     = "gitlab_mirroring_policy"
  description = "The name of the IAM policy attached to the GitLab Mirroring IAM User"
}


# Tags
variable "tags" {
  type = map(any)
  default = {
    "IAC_PROVIDER" = "Terraform"
  }
  description = "Tags to apply to resources"
}
