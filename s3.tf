resource "aws_s3_bucket" "photo_bucket" {
  bucket = "terraform-photo-background-storage"

  tags = {
    Name = "photo-storage"
  }
}

resource "aws_s3_bucket" "theme_bucket" {
  bucket = "photo-app-background-themes"

  tags = {
    Name = "background-themes"
  }
}