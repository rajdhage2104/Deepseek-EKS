output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.deepseek_instance.public_ip
}

# output "lb_url" {
#   description = "DNS name of the Application Load Balancer"
#   value       = aws_lb.deepseek_lb.dns_name
# }

# output "deepseek_ec2_sg_id" {
#   description = "Security Group ID of the EC2 instance"
#   value       = aws_security_group.deepseek_ec2_sg.id
# }