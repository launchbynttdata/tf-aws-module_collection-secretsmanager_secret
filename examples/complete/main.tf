// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "secrets_manager" {
  source = "../.."

  # Secret
  secret_name             = var.secret_name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = module.kms.key_arn
  tags                    = var.tags

  # Version
  ignore_secret_changes = var.ignore_secret_changes
  secret_string         = var.secret_string

  # Rotation
  enable_rotation     = var.enable_rotation
  rotation_lambda_arn = var.rotation_lambda_arn
  rotation_rules      = var.rotation_rules
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "3.1.0"

  description             = var.kms_key_description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
}

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = join("", split("-", var.region))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
}
