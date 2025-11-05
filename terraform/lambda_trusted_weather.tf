resource "aws_lambda_function" "lambda_trusted_weather" {
    filename = "${path.module}/files/scripts/python/treat_weather_data.zip"
    function_name = "lambda_treat_weather_data"
    role = "arn:aws:iam::${var.aws_user_id}:role/LabRole"
    handler = "treat_weather_data.lambda_handler"
    runtime = "python3.12"
    architectures = ["x86_64"]
    timeout = 240
    memory_size = 512
    source_code_hash = filebase64sha256("${path.module}/files/scripts/python/treat_weather_data.zip")
    layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python312:19"]
}