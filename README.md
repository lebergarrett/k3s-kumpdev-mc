# mc-kumpdev

Minecraft Server network using Terraform, Kubernetes, Ansible, and Docker Images.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. To simplify my instructions, I will be writing it as if you are using a debian-based system. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You will need to already have a working kubernetes cluster with kubectl configured in it's default location (modify the provider config if using an alternate path). This configuration is highly tailored toward my local kubernetes setup. The biggest issues I see for others would be my use of host-path mounting for volumes, and possibly choice of loadbalancers (metallb)

Terraform needs to be installed on your workstation. Refer to Terraform documentation

Refer to my `lebergarrett/mc-kumpdev-pv` repo and provision some persistent storage first. Ensure that the `server_name` var matches the one used in your var file here, as well as the servers listed in `server_list`. I do this to ensure that the server data persists when I run a `terraform destroy` here or make changes that require replacement.

### Installing

To get your environment running, you can go ahead and clone this repo locally using:

```bash
git clone https://github.com/lebergarrett/mc-kumpdev.git
```

Once cloned, you will need to create your own ddclient config file and place it at the root of the directory named `ddclient.conf` if you wish to use dynamic DNS.

You will also need to set up the mariadb credentials if you wish to stand up a paper server as I have it set up to automatically deploy luckperms for them. The vars are: 

```bash
MARIADB_USER
MARIADB_PASS
```

You can use terraform env vars to accomplish this securely until I set up something better for secret handling.

Once that is done, you can start working on a deployment. Server configs are located in the envs folder in various files, and there is plenty in there by default so it should hopefully be easy to understand. The backend.tf file will need to be modified for your own state storage.

I use terraform workspaces to separate my environments, so if you choose to reuse that, follow the guidance for the `terraform workspace` command.

## Deployment

Prio to deploying a network, refer to my `lebergarrett/mc-kumpdev-pv` repo and provision some persistent storage first. Once that is done, simply type the following while in the working dir and appropriate workspace:

```bash
terraform apply --var-file=envs/${VAR_FILE}.tfvars
```

It will take a minute or two to start, you can check the status of the network using the following (NOTE: server_name is in your var file, and will be used to create a kubernetes namespace):

```bash
kubectl get all -n ${SERVER_NAME}
```

## Additional Remarks

This is HIGHLY tailored to my personal setup so it will require quite a bit of work to get set up elsewhere at the moment, but hopefully it provides something useful to others.

## TODO

Secret handling (luckperms db, ddclient config)

Abstract away as much as possible to make it usable for others (modules, most likely)
