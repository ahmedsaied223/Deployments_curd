terraform {
  source = "../../modules/deployment"
}

inputs = {
  name            = "my-app-dev"
  namespace       = "dev"
  replicas        = 2
  container_image = "nginx:1.24"
  container_port  = 80
  labels = {
    environment = "dev"
    owner       = "team-a"
  }
  env_vars = [
    { key = "ENV", value = "dev" },
  ]
}

# If you need to configure the kubernetes provider from Terragrunt,
# use a provider wrapper or set environment variables (e.g., KUBECONFIG).
# Example: set KUBECONFIG in your shell before running terragrunt.
