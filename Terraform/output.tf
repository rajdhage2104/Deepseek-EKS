output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.deepseek_instance.public_ip
}

