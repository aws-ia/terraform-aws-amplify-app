variable "tags" {
  description = "Tags to apply to resources"
  type        = map(any)
  default     = {}
}

################################################################################
# App
################################################################################

variable "name" {
  type        = string
  default     = "sample-amplify-app"
  description = "The name of the Sample Amplify Application"
}

variable "build_spec" {
  type        = string
  default     = null
  description = "The actual content of your build_spec. Use if 'path_to_build_spec' is not defined"
}

variable "environment_variables" {
  type        = map(string)
  default     = null
  description = "Global environment variables for your Amplify App. These will only appear in the AWS Management Console if a git repo is connected"
}

variable "enable_auto_branch_creation" {
  type        = bool
  default     = false
  description = "Enables automated branch creation for the Amplify app"
}

variable "enable_auto_branch_deletion" {
  type        = bool
  default     = false
  description = "Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository"
}

variable "auto_branch_creation_patterns" {
  type        = list(any)
  default     = ["main", ]
  description = "Automated branch creation glob patterns for the Amplify app. Ex. feat*/*"
}

variable "enable_auto_build" {
  type        = bool
  default     = false
  description = "Enables auto-building of autocreated branches for the Amplify App"
}

variable "enable_pull_request_preview" {
  type        = bool
  default     = false
  description = "Enables pull request previews for the autocreated branch"
}

variable "enable_performance_mode" {
  type        = bool
  default     = false
  description = "Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes"
}

variable "framework" {
  type        = string
  default     = null
  description = "Framework for the autocreated branch"
}

variable "repository" {
  type        = string
  default     = null
  description = "URL for the existing repo"
}

variable "access_token" {
  type        = string
  default     = null
  description = "Optional GitHub access token. Only required if using GitHub repo"
}

################################################################################
# Branch(es)
################################################################################

variable "branches" {
  description = "Map of branch definitions to be created"
  type        = map(any)
  default     = {}
}

################################################################################
# Domain Association
################################################################################

variable "create_domain_association" {
  type        = bool
  default     = false
  description = "Enables default association of your domain with the 'main' branch of the Amplify App"
}

variable "domain_name" {
  type        = string
  default     = "example.com"
  description = "The name of your domain. Ex. naruto.ninja"
}

variable "sub_domains" {
  type        = map(any)
  default     = {}
  description = "The domains/subdomains you wish to associate with the Amplify App. These are mapped to git branches"
}

variable "wait_for_verification" {
  type        = bool
  default     = false
  description = "If set to 'true', the resource will wait for the domain association status to change to 'PENDING_DEPLOYMENT' or 'AVAILABLE'. Setting this to false will skip the process. Default is set to 'false'"
}

variable "custom_rules" {
  type        = map(any)
  default     = {}
  description = "Custom rewrites and redirects for the domain associations"
}

################################################################################
# CodeCommit
################################################################################

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

variable "amplify_codecommit_role_name" {
  type        = string
  default     = "amplify-codecommit"
  description = "Name for the role Amplify will use to access the CodeCommit repo"
}

################################################################################
# GitLab Mirror
################################################################################

variable "create_gitlab_mirror_iam_user" {
  type        = bool
  default     = false
  description = "Enables GitLab mirror to the option AWS CodeCommit repo"
}

variable "gitlab_mirror_iam_user_name" {
  type        = string
  default     = null
  description = "The IAM Username for the GitLab mirror IAM User"
}

variable "gitlab_mirror_policy_name" {
  type        = string
  default     = "gitlab_mirror_policy"
  description = "The name of the IAM policy attached to the GitLab mirror IAM User"
}
