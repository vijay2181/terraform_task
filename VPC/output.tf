# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.myvpc.id
}

# Output the Subnet IDs
output "public_subnet_1_id" {
  value = aws_subnet.my-public-subnet-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.my-public-subnet-2.id
}


# Output the Security Group IDs
output "public_sg_id" {
  value = aws_security_group.public-SG.id
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}
