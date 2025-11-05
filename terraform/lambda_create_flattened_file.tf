resource "aws_lambda_function" "lambda_create_flattened_file" {
    filename = "${path.module}/files/scripts/python/create_flattened_file.zip"
    function_name = "lambda_create_flattened_file"
    role = "arn:aws:iam::${var.aws_user_id}:role/LabRole"
    handler = "create_flattened_file.lambda_handler"
    runtime = "python3.12"
    architectures = ["x86_64"]
    timeout = 240
    source_code_hash = filebase64sha256("${path.module}/files/scripts/python/create_flattened_file.zip")
    layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python312:19"]
}