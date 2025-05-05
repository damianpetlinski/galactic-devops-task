locals {
  is_local    = var.provider_type == "local"
  api_invoke_url = module.apigw.invoke_url
}
