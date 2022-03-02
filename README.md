<<<<<<< HEAD
---

## HOW-TO

# HOW-TO
>>>>>>> 668026377c2f8f43ba2fc6fc0ce30753c3610ee5

Clone this repo into the suitable for you directory and enter this directory.

Before the very start you'll want to initialize the terraform first:

```bash
<<<<<<< HEAD
~$ terraform init
=======
~$ terraform init -backend-config=backend.tfvars -upgrade
>>>>>>> 668026377c2f8f43ba2fc6fc0ce30753c3610ee5
```

To create infrastructure from the scratch run:

```bash
~$ terraform plan -out=ripper.tfplan
```

after that check all output, and if satisfied, run:

```bash
~$ terraform apply "ripper.tfplan"
```

and type "yes" to approve setup.
To approve non-interactivly - just add `-auto-approve` to the command above

Terraform creates *.tfstate* file in the S3 bucket 

---
kubectl connect to existing eks cluster:

```bash
~$ aws eks --region <region-code> update-kubeconfig --name <cluster_name>
```
<<<<<<< HEAD
---
## Deploy containers
```bash
~$ kubectl apply -f /path/to/ripper-deployment.yaml
```
working example you c
>>>>>>> 668026377c2f8f43ba2fc6fc0ce30753c3610ee5
