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

output "arn" {
  description = "The ARN of the secret"
  value       = module.secrets_manager.arn
}

output "id" {
  description = "The ID of the secret"
  value       = module.secrets_manager.id
}

output "secret_replica" {
  description = "Attributes of the replica created"
  value       = module.secrets_manager.secret_replica
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = module.secrets_manager.secret_version_id
}
