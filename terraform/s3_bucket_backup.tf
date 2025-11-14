resource "aws_s3_bucket" "grupo4_s3_backup" {
  bucket = "beauty-barreto-backup"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "grupo4_s3_backup_versioning" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_backup_encryption" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grupo4_s3_backup_public_access_block" {
  bucket                  = aws_s3_bucket.grupo4_s3_backup.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "grupo4_s3_backup_frontend_dir" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id
  key    = "frontend/"
}

resource "aws_s3_object" "grupo4_s3_backup_backend_dir" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id
  key    = "backend/"
}

resource "aws_s3_object" "grupo4_s3_backup_database_dir" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id
  key    = "database/"
}