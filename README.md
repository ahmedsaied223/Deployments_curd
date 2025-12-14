# Create, Update & Delete Deployment

This example program demonstrates the fundamental operations for managing on
[Deployment][1] resources, such as `Create`, `List`, `Update` and `Delete`.

You can adopt the source code from this example to write programs that manage
other types of resources through the Kubernetes API.

## Running this example

Make sure you have a Kubernetes cluster and `kubectl` is configured:

    kubectl get nodes

Compile this example on your workstation:

```
cd create-update-delete-deployment
go build -o ./app
```

Now, run this application on your workstation with your local kubeconfig file:

```
./app
# or specify a kubeconfig file with flag
./app -kubeconfig=$HOME/.kube/config
```

Running this command will execute the following operations on your cluster:

1. **Create Deployment:** This will create a 2 replica Deployment. Verify with
   `kubectl get pods`.
2. **Update Deployment:** This will update the Deployment resource created in
   previous step by setting the replica count to 1 and changing the container
   image to `nginx:1.13`. You are encouraged to inspect the retry loop that
   handles conflicts. Verify the new replica count and container image with
   `kubectl describe deployment demo`.
3. **List Deployments:** This will retrieve Deployments in the `default`
   namespace and print their names and replica counts.
4. **Delete Deployment:** This will delete the Deployment object and its
   dependent ReplicaSet resource. Verify with `kubectl get deployments`.

Each step is separated by an interactive prompt. You must hit the
<kbd>Return</kbd> key to proceed to the next step. You can use these prompts as
a break to take time to run `kubectl` and inspect the result of the operations
executed.

You should see an output like the following:

```
Creating deployment...
Created deployment "demo-deployment".
-> Press Return key to continue.

Updating deployment...
Updated deployment...
-> Press Return key to continue.

Listing deployments in namespace "default":
 * demo-deployment (1 replicas)
-> Press Return key to continue.

Deleting deployment...
Deleted deployment.
```

## Cleanup

Successfully running this program will clean the created artifacts. If you
terminate the program without completing, you can clean up the created
deployment with:

    kubectl delete deploy demo-deployment

## Troubleshooting

If you are getting the following error, make sure Kubernetes version of your
cluster is v1.6 or above in `kubectl version`:

    panic: the server could not find the requested resource

[1]: https://kubernetes.io/docs/user-guide/deployments/




# Deployments_curd

This repository demonstrates the fundamental Create, Read (List), Update and Delete (CRUD) operations for Kubernetes Deployment resources using Terraform and Terragrunt. The code is organized as a reusable Terraform module plus Terragrunt configuration for environment-specific orchestration.

Goals
- Show how to declare a Kubernetes Deployment with Terraform.
- Show how to structure Terragrunt to call the module per-environment.
- Demonstrate the workflow to create, list, update and delete Deployments.

Prerequisites
- Terraform (>= 1.0)
- Terragrunt (>= 0.40)
- kubectl configured to access the target Kubernetes cluster
- KUBECONFIG environment set (or kube context configured)
- Access to the Kubernetes API from where you run Terraform (or use a provider that can authenticate from CI)

Repository layout (recommended)
- modules/
  - deployment/        # Terraform module that manages a Kubernetes Deployment
- live/
  - dev/
    - terragrunt.hcl   # Terragrunt config for dev
  - prod/
    - terragrunt.hcl   # Terragrunt config for prod

Quick concepts
- Create: terragrunt apply (or terraform apply inside module)
- List: kubectl get deployments -n <namespace>
- Update: modify variables (image, replicas, envs) and terragrunt apply
- Delete: terragrunt destroy

Example workflow (using Terragrunt)
1. Enter environment
   cd live/dev
2. Create/Update resources
   terragrunt init
   terragrunt apply
3. Check deployed resources (kubectl)
   kubectl get deployments -n <namespace>
4. Update (change image or replicas in terraform variables)
   terragrunt apply
5. Delete
   terragrunt destroy

Terraform / Kubernetes provider notes
- This example uses the official Terraform kubernetes provider (registry.terraform.io/hashicorp/kubernetes).
- Provider authentication methods vary (client certs, token, in-cluster). Ensure your environment authenticates correctly.

Example variables you may change
- name: Deployment name
- namespace: Kubernetes namespace
- replicas: number of replicas
- container_image: container image (e.g., nginx:1.24)
- container_port: port exposed by the container

Security
- Do not commit kubeconfigs or secrets to the repository.
- Use secret management (e.g., Kubernetes Secrets, Vault) for sensitive data.

Next steps / recommendations
- Add CI that runs terragrunt plan on changes.
- Integrate image update automation (e.g., Flux, ArgoCD) if desired.
- Add health checks, resource requests/limits, and probes to the module.

If you'd like, I can:
- create the Terraform module files and a sample Terragrunt config in this repo,
- or adapt the module to use a different provider or authentication method.
