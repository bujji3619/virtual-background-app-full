resource "aws_launch_template" "photo_template" {

  name_prefix   = "photo-template"
  image_id      = "ami-06e3c045d79fd65d9"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "photo-app-instance"
    }
  }
}

resource "aws_autoscaling_group" "photo_asg" {

  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]

launch_template {
    id      = aws_launch_template.photo_template.id
    version = "$Latest"
}

  tag {
    key                 = "Name"
    value               = "photo-asg"
    propagate_at_launch = true
  }
}
