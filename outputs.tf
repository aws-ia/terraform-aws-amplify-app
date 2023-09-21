output "amplify_app_id" {
  value       = aws_amplify_app.this.id
  description = "The App ID for the Amplify App"
}

output "amplify_app_arn" {
  value       = aws_amplify_app.this.arn
  description = "The ARN for the Amplify App"
}

output "amplify_app_default_domain" {
  value       = aws_amplify_app.this.default_domain
  description = "The default domain for the Amplify App"
}

output "amplify_app_production_branch" {
  value       = aws_amplify_app.this.default_domain
  description = "The production branch for the Amplify App"
}

output "amplify_app_tags_all" {
  value       = aws_amplify_app.this.tags_all
  description = "All tags for the Amplify App"
}
