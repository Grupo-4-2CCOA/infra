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
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "grupo4_s3_backup_policy" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ListBackupBucket"
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:ListBucket"]
        Resource = aws_s3_bucket.grupo4_s3_backup.arn
      },
      {
        Sid = "PutBackupObjects"
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:PutObject", "s3:PutObjectAcl"]
        Resource  = "${aws_s3_bucket.grupo4_s3_backup.arn}/database/*"
      }
    ]
  })
}

resource "aws_s3_object" "grupo4_s3_backup_database_dir" {
  bucket = aws_s3_bucket.grupo4_s3_backup.id
  key    = "database/"
}