//==================================== Restrict EKS ORDER
resource "aws_apigatewayv2_integration" "eks_integration_payment" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  integration_uri    = var.eks_private_load_balancer_arn_payment
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = var.aws_apigatewayv2_vpc_link_eks_id

  request_parameters = {
    "overwrite:path" = "$request.path"
    "append:header.x-user-identifier" = "$context.authorizer.userIdentifier"
  }

}

resource "aws_apigatewayv2_route" "v1_payment" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "POST /v1/totem/payment"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_payment.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

resource "aws_apigatewayv2_route" "v1_payment_by_id" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "GET /v1/totem/payment/{paymentId}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_payment.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

resource "aws_apigatewayv2_route" "v1_payment_params" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "ANY /v1/totem/payment/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_payment.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

resource "aws_apigatewayv2_route" "v1_payment_callback" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "POST /v1/totem/payment/callback"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_payment.id}"
}

//====================================

