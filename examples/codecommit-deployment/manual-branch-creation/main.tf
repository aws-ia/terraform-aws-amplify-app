// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "aws-amplify-app" {
  // location of the module - can be local or git repo
  source = "../../../" // local module
  # source = "aws-ia/amplify-app/aws" // remote module

  app_name                        = "my-app" // Name of the Amplify App - default is 'sample-amplify-app'
  create_codecommit_repo          = true     // Creates CodeCommit repo and necessary permissions for Amplify App to read from it. Default value is `false`
  lookup_existing_codecommit_repo = false    // Default value - set to `true` if you wish to use an existing CodeCommit repo
  # existing_repo_url = "" // If using the module to create a CodeCommit Repo, the repo's url is already referenced. If using your own repo, change this value to that repo url.

  path_to_build_spec = "../amplify.yml" // Example path if you want build_spec to be in a specific file. Only use if you are not using 'build_spec' variable

  # buildspec = "" // If you want to have your build_spec defined in main.tf - Only use if you are not using 'path_to_build_spec' variable

  // For this to work with domain associations, the branches must already exist in your
  // connected git repo. See the README for more information.
  // Auto Branch Creation
  enable_auto_branch_creation   = false           // default value is false - enables Amplify branches to be automatically created based on the `auto_branch_creation_patterns`. For these to build, `enable_auto_build` must be set to true, and they must exist in your connected git repo.
  enable_auto_branch_deletion   = false           // allows for branches in Amplify to automatically be deleted if you delete a branch with the same name from your connected git repo.
  auto_branch_creation_patterns = ["main", "dev"] // default values - this is the pattern that Amplify will use to decide which branches to auto build. Add additional strings inside the list to add additional branches. Ex. ["main", "dev", "staging"]
  enable_auto_build             = false           // auto builds the connected branch when code exists in it, or is pushed to it.
  enable_app_pr_preview         = false           // default value - adds preview to pull request
  enable_performance_mode       = false           // default value - caches data longer in CDN
  app_framework                 = "Something bloated and hard to maintain"


  // Global environment variables for the app. These will only appear if a git repo is connected
  environment_variables = {
    env-var = "hello"
  }

  // Use this variable if you wish to create your own branches manually.
  // Do NOT use this variable if you have 'auto_branch_creation' set to 'true'.
  manual_branches = {
    main = {
      branch_name = "main"
      framework   = "None"
      // Accepted values are "PRODUCTION", "DEVELOPMENT", "BETA", "PULL_REQUEST", "EXPERIMENTAL"
      stage = "PRODUCTION"
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

  // - Custom Domain -
  create_domain_associations = false            // Default value - set this to `true` after you create branches in your connected git repo and push to them
  domain_name                = "yourdomain.com" // The domain you wish to associate with the Amplify App. Do not include the `www.` This value is unused unless `create_domain_associations` is set to true. If set to true, you must also define the associations in `domain_associations`. It is recommended to use a domain managed by Route53 because if it's in the same account/region as your Amplify App, Amplify will automatically do the domain validation for you

  // Associates your domain/desired subdomains to git branches. Only takes effect if `create_domain_associations` is set to `true`
  domain_associations = {
    core = {
      branch_name = "main" // Name must match a git branch that already exists
      prefix      = ""
    },
    www = {
      branch_name = "main"
      prefix      = "www" // used so www.yourdomain.com and yourdomain.com have same content
    },
    # redirect_to_www = {
    #   source = "https://yourdomain.com"
    #   status = "302"
    #   target = "https://www.yourdomain.com" // redirects traffic to `www.yourdomain.com`
    # },
    dev = {
      branch_name = "dev"
      prefix      = "dev" // Adds association for `dev.yourdomain.com`
    }
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
