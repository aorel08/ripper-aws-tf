123
# HOW-TO

Clone this repo into the suitable for you directory and enter this directory.

Before the very start you'll want to initialize the terraform first:

```bash
~$ terraform init -backend-config=backend.tfvars -upgrade
```

To create infrastructure from the scratch run:
*example for staging*

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

Edit ConfigMap of an existing cluster:

```bash
~$ kubectl edit cm aws-auth -n kube-system
```

If you want to control what identity you are using, run:

```bash
~$ aws sts get-caller-identity
{
    "UserId": "AIDAXB2O*************",
    "Account": "**********36",
    "Arn": "arn:aws:iam::**********36:user/andrey.o"
}
```
---
## Deploy containers
```bash
~$ kubectl apply -f /path/to/ripper-deployment.yaml
```
working example you can find in deployments directory

