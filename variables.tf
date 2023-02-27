variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "env" {
  type        = string
  description = "Set environment"
  default     = "prod"
}
variable "domain_name" {
  type        = string
  description = "Set domain_name"
}
variable "basic_auth_domain_name" {
  type        = string
  description = "Set S3_basic_auth_domain_name"
}
variable "basic_auth_user" {
  type        = string
  description = "Username for Basic auth"
}
variable "lambda_name" {
  type        = string
  description = "Insert lambda name"
  default     = "lambda_function_basic_auth"
}