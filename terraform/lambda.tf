# resource "aws_lambda_function" "lambda_function" {
#     filename         = "lambda_function_payload.zip"
#     function_name    = "my_lambda_function"
#     role             = aws_iam_role.iam_for_lambda.arn
#     handler          = "exports.handler"
#     source_code_hash = filebase64sha256("lambda_function_payload.zip")
#     runtime          = "nodejs14.x"
    
#     environment {
#         variables = {
#         foo = "bar"
#         }
#     }
# }