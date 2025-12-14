terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  # Provider configuration is intentionally left to the root/terragrunt layer.
  # Example:
  # config_path = var.kubeconfig (or use in-cluster config)
  # For Terragrunt, you can set provider aliases or rely on kube context.
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.this.metadata[0].name
    labels = merge(
      var.labels,
      { "app" = var.name }
    )
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        "app" = var.name
      }
    }

    template {
      metadata {
        labels = {
          "app" = var.name
        }
      }

      spec {
        container {
          name  = var.name
          image = var.container_image
          port {
            container_port = var.container_port
          }

          # Example of environment variables
          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.value.key
              value = env.value.value
            }
          }

          # Add resources/readiness/liveness probes as needed
        }
      }
    }
  }
}
