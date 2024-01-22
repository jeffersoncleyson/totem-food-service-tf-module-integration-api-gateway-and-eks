//==================================== Restrict EKS ADMINISTRATIVE
resource "aws_apigatewayv2_integration" "eks_integration_administrative_order" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  integration_uri    = var.eks_private_load_balancer_arn_order
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = var.aws_apigatewayv2_vpc_link_eks_id

  request_parameters = {
    "overwrite:path" = "$request.path"
    "append:header.x-user-identifier" = "$context.authorizer.userIdentifier"
  }

}

resource "aws_apigatewayv2_route" "v1_administrative_order" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "ANY /v1/administrative/order/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_administrative_order.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

//====================================