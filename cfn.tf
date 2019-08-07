resource "null_resource" "cdk_deploy" {
  provisioner "local-exec" {
    command     = "npx cdk deploy '*' --require-approval never"
    working_dir = "cfn/"
    environment = {
      FOO = "bar"
    }
  }
}


data "aws_cloudformation_stack" "cdk" {
  name = "terraform-aws-cdk-template"

  depends_on = [null_resource.cdk_deploy]
}

output "function_name" {
  value = data.aws_cloudformation_stack.cdk.outputs.functionname
}

