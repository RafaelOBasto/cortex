#############################
# Security Groups
#############################

resource "aws_security_group" "CASE-SG" {
  name        = "CASE-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.aws_vpc
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "CASE-SG",
    Name = "Terraform" 
    Value = "True"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CASE-SG.id
}

resource "aws_security_group_rule" "postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CASE-SG.id
}

resource "aws_security_group_rule" "web" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CASE-SG.id
}


resource "aws_key_pair" "user" {
  key_name   = "user-key"
  public_key = var.user_public_key
}