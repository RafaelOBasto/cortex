###########################
# Output variables
###########################

output "instance_public_ip_addr" {
  value = aws_instance.server.public_ip
}


