output "ec2_sg_id" {
    value = aws_security_group.sg["test-sg"].id
}