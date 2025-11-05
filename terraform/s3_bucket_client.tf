resource "aws_s3_bucket" "grupo4_s3_client" {
  bucket = "beauty-barreto-client"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "grupo4_s3_client_versioning" {
  bucket = aws_s3_bucket.grupo4_s3_client.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_client_encryption" {
  bucket = aws_s3_bucket.grupo4_s3_client.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grupo4_s3_client_public_access_block" {
  bucket                  = aws_s3_bucket.grupo4_s3_client.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "grupo4_s3_client_query_dir" {
  bucket = aws_s3_bucket.grupo4_s3_client.id
  key    = "queries/"
}

resource "aws_s3_object" "grupo4_s3_client_data_dir" {
  bucket = aws_s3_bucket.grupo4_s3_client.id
  key    = "flattened/"
}

resource "aws_s3_object" "grupo4_s3_client_result_dir" {
  bucket = aws_s3_bucket.grupo4_s3_client.id
  key    = "results/"
}