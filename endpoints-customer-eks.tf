//==================================== Restrict EKS CUSTOMER
resource "aws_apigatewayv2_integration" "eks_integration_customer" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  integration_uri    = var.eks_private_load_balancer_arn_customer
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = var.aws_apigatewayv2_vpc_link_eks_id

  request_parameters = {
    "overwrite:path" = "$request.path"
    "append:header.x-user-identifier" = "$context.authorizer.userIdentifier"
  }

}

resource "aws_apigatewayv2_route" "create_users" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "POST /v1/totem/customer"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_customer.id}"
}

resource "aws_apigatewayv2_route" "confirm_users" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "PUT /v1/totem/customer/{customerId}/code/{code}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_customer.id}"
}

resource "aws_apigatewayv2_route" "get_customer_by_id" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "GET /v1/totem/customer/{customerId}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_customer.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

resource "aws_apigatewayv2_route" "delete_customer_by_id" {
  api_id = var.aws_apigatewayv2_api_restrict_api_id

  route_key          = "DELETE /v1/totem/customer/{customerId}"
  target             = "integrations/${aws_apigatewayv2_integration.eks_integration_customer.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = var.aws_apigatewayv2_authorizer_authorizer_id
}

//====================================
