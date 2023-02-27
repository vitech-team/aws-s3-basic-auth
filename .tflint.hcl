#For use this tflint configure use command:
#find . -not -path \*.terraform\* -type f -iname \*.tf -execdir pwd \; | sort -u | xargs -n1 tflint --color
config {
  module     = false
  plugin_dir = "~/.tflint.d/plugins"
}

# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/README.md
rule "terraform_comment_syntax" { enabled = true }
rule "terraform_deprecated_index" { enabled = true }
rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_documented_outputs" { enabled = true }
rule "terraform_documented_variables" { enabled = true }
rule "terraform_empty_list_equality" { enabled = true }
rule "terraform_module_pinned_source" { enabled = true }
rule "terraform_module_version" { enabled = true }
rule "terraform_naming_convention" {
  enabled = true
  custom = "^[a-zA-Z0-9]+([_-][a-zA-Z0-9]+)*$"
}
rule "terraform_required_providers" { enabled = true }
rule "terraform_required_version" { enabled = true }
rule "terraform_standard_module_structure" { enabled = true }
rule "terraform_typed_variables" { enabled = true }
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_unused_required_providers" { enabled = true }
rule "terraform_workspace_remote" { enabled = true }

# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md
plugin "aws" {
  source     = "github.com/terraform-linters/tflint-ruleset-aws"
  version    = "0.21.1"
  deep_check = true
  enabled    = true
}