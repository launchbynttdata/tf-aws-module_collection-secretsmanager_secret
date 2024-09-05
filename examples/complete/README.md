# with_cake

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | ../.. | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-aws-modules/kms/aws | 3.1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"backend"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) The location where the resource will be created. Must not have spaces<br>    For example, us-east-1, us-west-2, eu-west-1, etc. | `string` | `"us-east-2"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_maximum_length"></a> [maximum\_length](#input\_maximum\_length) | Number that represents the maximum length the resource name could have. | `number` | `60` | no |
| <a name="input_separator"></a> [separator](#input\_separator) | Separator to be used in the name | `string` | `"-"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names. | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "s3_bucket": {<br>    "name": "s3"<br>  }<br>}</pre> | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | The description of the secrets. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the secrets. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30 | `number` | `null` | no |
| <a name="input_ignore_secret_changes"></a> [ignore\_secret\_changes](#input\_ignore\_secret\_changes) | Determines whether or not Terraform will ignore changes made externally to secret\_string or secret\_binary. Changing this value after creation is a destructive operation | `bool` | `false` | no |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | The JSON string containing the secret data | `string` | `null` | no |
| <a name="input_enable_rotation"></a> [enable\_rotation](#input\_enable\_rotation) | Whether to enabled rotation for the secret | `bool` | `false` | no |
| <a name="input_rotation_lambda_arn"></a> [rotation\_lambda\_arn](#input\_rotation\_lambda\_arn) | The ARN of the Lambda function that performs rotation | `string` | `""` | no |
| <a name="input_rotation_rules"></a> [rotation\_rules](#input\_rotation\_rules) | Rotation rules for the secret, including the schedule expression | `object({})` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`). Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_kms_key_description"></a> [kms\_key\_description](#input\_kms\_key\_description) | KMS key description. This KMS key is used for SSE-KMS encryption f source bucket. | `string` | `"KMS key used for source bucket encryption"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30 | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the secret |
| <a name="output_id"></a> [id](#output\_id) | The ID of the secret |
| <a name="output_secret_replica"></a> [secret\_replica](#output\_secret\_replica) | Attributes of the replica created |
| <a name="output_secret_version_id"></a> [secret\_version\_id](#output\_secret\_version\_id) | The unique identifier of the version of the secret |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
