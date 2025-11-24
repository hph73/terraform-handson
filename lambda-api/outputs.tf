output "api-gateway-url" {
  value = "${aws_api_gateway_stage.example.invoke_url}/${aws_api_gateway_resource.MyDemoResource.path_part}"
}