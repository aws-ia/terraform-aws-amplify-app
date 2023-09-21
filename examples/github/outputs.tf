################################################################################
# App
################################################################################

output "arn" {
  description = "ARN of the Amplify app"
  value       = module.amplify_app.arn
}

output "default_domain" {
  description = "Default domain for the Amplify app"
  value       = module.amplify_app.default_domain
}

output "id" {
  description = "Unique ID of the Amplify app"
  value       = module.amplify_app.id
}

output "production_branch" {
  description = "Describes the information about a production branch for an Amplify app"
  value       = module.amplify_app.production_branch
}

################################################################################
# Branch(es)
################################################################################

output "domain_association_arn" {
  description = "ARN of the Amplify domain association"
  value       = module.amplify_app.domain_association_arn
}

output "domain_association_certificate_verification_dns_record" {
  description = "The DNS record for certificate verification"
  value       = module.amplify_app.domain_association_certificate_verification_dns_record
}

################################################################################
# Domain Association
################################################################################

# TODO !!!

################################################################################
# CodeCommit Repository
################################################################################

# TODO !!!

################################################################################
# GitLab Mirror IAM User
################################################################################

# TODO !!!
