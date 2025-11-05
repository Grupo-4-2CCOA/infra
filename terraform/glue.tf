resource "aws_glue_catalog_database" "grupo4_glue_db" {
  name = "grupo4_glue_db"
}

resource "aws_glue_crawler" "grupo4_glue_crawler" {
  name = "grupo4-glue-crawler"
  database_name = aws_glue_catalog_database.grupo4_glue_db.name
  role = "arn:aws:iam::${var.aws_user_id}:role/LabRole"
  table_prefix = "bb_"
  
  s3_target {
    path = "s3://${aws_s3_bucket.grupo4_s3_client.bucket}/flattened/"
  }
}