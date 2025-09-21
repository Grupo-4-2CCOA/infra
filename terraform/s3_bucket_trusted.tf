resource "aws_s3_bucket" "trusted" {
  bucket = "BeautyBarreto-trusted"
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "trusted" {
  bucket = aws_s3_bucket.trusted.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trusted" {
  bucket = aws_s3_bucket.trusted.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "trusted" {
  bucket                  = aws_s3_bucket.trusted.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}