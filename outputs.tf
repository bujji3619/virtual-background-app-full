output "server_ip" {
  value = aws_instance.photo_app.public_ip
}