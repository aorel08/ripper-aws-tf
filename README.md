# Description

This is the Terraform manifest to provision the whole Dublz infrastructure from the scratch.

**To be able to run this, you need to be sure that you have installed all required utilities:**

## Terraform

The latest version of the terraform is v0.14.5, but for this installation the version of the terraform is v0.12.29.
To install it go to [releases](https://releases.hashicorp.com/terraform/0.12.29/) and download your OS specific zip archive.
Unzip downloaded file and copy it to
*for Linux users:*
/usr/local/bin/terraform
*for Windows users:*
to any suitable location, just be sure this location is added to the environment $PATH.

## AWS CLI

[Installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## kubectl

[Installation guide](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)

## Helm

[Installation guide](https://helm.sh/docs/intro/install/)

---

## HOW-TO

```diff
- (this block is a draft, so may be ignored)
```

Clone this repo into the suitable for you directory and enter this directory.

Before the very start you'll want to initialize the terraform first:

```bash
~$ terraform init
```

To create infrastructure from the scratch run:
*example for staging*

```bash
~$ terraform plan -out=staging.tfplan -var-file=network-staging.tfvars -var-file=eks-staging.tfvars -var-file=ingress-staging.tfvars -var-file=subdomains-staging.tfvars
```

after that check all output, and if satisfied, run:

```bash
~$ terraform apply "staging.tfplan"
```

and type "yes" to approve setup.
To approve non-interactivly - just add `-auto-approve` to the command above

Terraform creates *.tfstate* file in the

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
    "UserId": "AIDAXB2OY72OEHSGKCIHB",
    "Account": "484959649436",
    "Arn": "arn:aws:iam::484959649436:user/andrey.o"
}
```
