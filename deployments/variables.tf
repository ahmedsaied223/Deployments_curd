variable "name" {
  type        = string
  description = "Deployment name"
  default     = "example-deployment"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "default"
}

variable "replicas" {
  type        = number
  description = "Number of replicas"
  default     = 1
}

variable "container_image" {
  type        = string
  description = "Container image"
  default     = "nginx:latest"
}

variable "container_port" {
  type        = number
  description = "Container port"
  default     = 80
}

variable "labels" {
  type        = map(string)
  description = "Additional labels to attach"
  default     = {}
}

# env_vars should be a list of objects like [{key="FOO", value="bar"}]
variable "env_vars" {
  type        = list(object({ key = string, value = string }))
  description = "Environment variables for the container"
  default     = []
}
