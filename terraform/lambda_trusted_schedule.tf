resource "aws_lambda_function" "lambda_trusted_schedule" {
    filename = "${path.module}/files/scripts/python/treat_schedule_data.zip"
    function_name = "lambda_treat_schedule_data"
    role = "arn:aws:iam::${var.aws_user_id}:role/LabRole"
    handler = "treat_schedule_data.lambda_handler"
    runtime = "python3.12"
    architectures = ["x86_64"]
    timeout = 240
    source_code_hash = filebase64sha256("${path.module}/files/scripts/python/treat_schedule_data.zip")
    layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python312:19"]
}