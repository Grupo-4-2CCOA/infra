resource "aws_s3_bucket" "grupo4_s3_trusted" {
  bucket = "beauty-barreto-trusted"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "grupo4_s3_trusted_versioning" {
  bucket = aws_s3_bucket.grupo4_s3_trusted.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_trusted_encryption" {
  bucket = aws_s3_bucket.grupo4_s3_trusted.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grupo4_s3_trusted_public_access_block" {
  bucket                  = aws_s3_bucket.grupo4_s3_trusted.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}