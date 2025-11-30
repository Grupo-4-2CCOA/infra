resource "aws_s3_bucket" "grupo4_s3_source" {
  bucket = "beauty-barreto-source"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "grupo4_s3_source_versioning" {
  bucket = aws_s3_bucket.grupo4_s3_source.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "grupo4_s3_source_policy" {
  bucket = aws_s3_bucket.grupo4_s3_source.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.grupo4_s3_source.arn}/*"
      }
    ]
  })
}


resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_source_encryption" {
  bucket = aws_s3_bucket.grupo4_s3_source.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grupo4_s3_source_public_access_block" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "grupo4_s3_source_image_1" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  key    = "corte-de-cabelo.jpg"
  source = "${path.module}/files/images/corte-de-cabelo.jpg"
}

resource "aws_s3_object" "grupo4_s3_source_image_2" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  key    = "manicure-simples.jpg"
  source = "${path.module}/files/images/manicure-simples.jpg"
}

resource "aws_s3_object" "grupo4_s3_source_image_3" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  key    = "pedicure.jpg"
  source = "${path.module}/files/images/pedicure.jpg"
}

resource "aws_s3_object" "grupo4_s3_source_image_4" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  key    = "unha-gel.jpg"
  source = "${path.module}/files/images/unha-gel.jpg"
}

resource "aws_s3_object" "grupo4_s3_source_image_5" {
  bucket = aws_s3_bucket.grupo4_s3_source.id
  key    = "limpeza-simples.jpg"
  source = "${path.module}/files/images/limpeza-simples.jpg"
}