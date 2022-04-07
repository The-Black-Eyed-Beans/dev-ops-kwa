output "security_group_http" {
  description = "HTTP security group id"
  value = aws_security_group.http.id
}

output "security_group_ssh" {
  description = "SSH security group id"
  value = aws_security_group.ssh.id
}

