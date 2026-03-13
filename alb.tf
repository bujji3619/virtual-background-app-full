resource "aws_lb" "app_alb" {
  name               = "photo-app-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]

  security_groups = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "photo-app-alb"
  }
}