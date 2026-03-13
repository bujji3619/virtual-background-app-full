resource "aws_security_group" "pic_sg" {
  name = "photo-app-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "photo_app" {
  ami           = "ami-06e3c045d79fd65d9"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet1.id

  vpc_security_group_ids = [
     aws_security_group.app_sg.id
]
  

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install docker.io -y
              sudo systemctl start docker
              docker run -d -p 80:3000 photo-app
              EOF

  tags = {
    Name = "photo-app-server"
  }
}
