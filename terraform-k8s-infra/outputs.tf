#Terraform will display these values after successful provisioning.

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "application_url" {
  description = "URL for testing the Node.js application"
  value       = "http://${aws_instance.app_server.public_ip}:3000/health"
}
