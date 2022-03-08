output "security_group_ids" {
  description = "List of security group ids"
  value = [
    aws_security_group.http.id,
    aws_security_group.ssh.id,
  ]
}
