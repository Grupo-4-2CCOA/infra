resource "aws_s3_bucket" "grupo4_s3_raw" {
  bucket = "beauty-barreto-raw"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "grupo4_s3_raw_versioning" {
  bucket = aws_s3_bucket.grupo4_s3_raw.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "grupo4_s3_raw_encryption" {
  bucket = aws_s3_bucket.grupo4_s3_raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "grupo4_s3_public_access_block" {
  bucket                  = aws_s3_bucket.grupo4_s3_raw.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_notification" "grupo4_s3_raw_notification" {
#   bucket = aws_s3_bucket.grupo4_s3_raw.id

#   lambda_function {
#     events = ["s3:ObjectCreated:*"]
#     filter_prefix = "holidays/"
#     filter_suffix = ".csv"
#     lambda_function_arn = aws_lambda_function.lambda_trusted_holiday.arn
#   }
# }

resource "aws_s3_object" "grupo4_s3_raw_holiday_data" {
  bucket = aws_s3_bucket.grupo4_s3_raw.id
  key    = "holidays/holiday_data.csv"
  source = "${path.module}/files/csv/holidays.csv"
}

resource "aws_s3_object" "grupo4_s3_raw_weather_data" {
  bucket = aws_s3_bucket.grupo4_s3_raw.id
  key    = "weathers/weather_data.csv"
  source = "${path.module}/files/csv/southeast.csv"
}

resource "aws_s3_object" "grupo4_s3_schedule_data" {
  bucket = aws_s3_bucket.grupo4_s3_raw.id
  key    = "schedules/schedule_data.csv"
  source = "${path.module}/files/csv/schedule.csv"
}