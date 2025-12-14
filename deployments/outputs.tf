output "deployment_name" {
  value = kubernetes_deployment.this.metadata[0].name
}

output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}
