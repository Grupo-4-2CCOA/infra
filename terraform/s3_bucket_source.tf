# resource "aws_s3_bucket" "grupo4_s3_source" {
#   bucket = "beauty-barreto-source"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "grupo4_s3_source_versioning" {
#   bucket = aws_s3_bucket.grupo4_s3_source.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_source_encryption" {
#   bucket = aws_s3_bucket.grupo4_s3_source.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "grupo4_s3_source_public_access_block" {
#   bucket                  = aws_s3_bucket.grupo4_s3_source.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }