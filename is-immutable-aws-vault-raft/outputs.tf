output "vault_lb" {
  value       = aws_lb.vault.dns_name
  description = "The hostname of Vault's loadbalancer."
}

output "vault_dns" {
  value       = aws_route53_record.vault_lb.fqdn
  description = "DNS entry for accessing Vault."
}