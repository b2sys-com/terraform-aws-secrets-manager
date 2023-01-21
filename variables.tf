variable "secret_manager_name" {
  description = "Name of the Secrets to create in Secrets Manager"
}

variable "secrets_manager_values" {
  description = "Values to store in Secrets Manager in Json format"
  type        = map(string)
  default     = null
}

variable "secrets_manager_string" {
  description = "Values to store in Secrets Manager in String format"
  type        = string
  default     = null
}

variable "master_key_spec" {
  description = "Encryption algorithms"
  default     = "SYMMETRIC_DEFAULT"
}

variable "secrets_tags" {
  description = "Map of tags to be use in Secrets Manager resource creation"
  default     = {}
}

variable "region_replication" {
  description = "AWS Region to replicate Secrets"
  default     = "us-west-2"
  type        = string
}

variable "replication" {
  description = "Enable Replication"
  default     = false
  type        = bool
}