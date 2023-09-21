################################################################################
# App
################################################################################

output "arn" {
  description = "ARN of the Amplify app"
  value       = aws_amplify_app.this.arn
}

output "default_domain" {
  description = "Default domain for the Amplify app"
  value       = aws_amplify_app.this.default_domain
}

output "id" {
  description = "Unique ID of the Amplify app"
  value       = aws_amplify_app.this.id
}

output "production_branch" {
  description = "Describes the information about a production branch for an Amplify app"
  value       = aws_amplify_app.this.production_branch
}

################################################################################
# Branch(es)
################################################################################

output "domain_association_arn" {
  description = "ARN of the Amplify domain association"
  value       = try(aws_amplify_domain_association.this[0].arn, null)
}

output "domain_association_certificate_verification_dns_record" {
  description = "The DNS record for certificate verification"
  value       = try(aws_amplify_domain_association.this[0].certificate_verification_dns_record, null)
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
