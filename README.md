Edu lab with work Terraform and Packer in infrastructure Yandex Cloud

# Preparing 
## Terraform from blocked country
setting mirror Yandex for Terraform:
```bash
cp .terraformrc ~
```
## Install YC cli 
[How install](https://cloud.yandex.com/en/docs/cli/operations/install-cli)
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```
# How use

Get available ZONEs - `yc compute zone list`\
Get available SUBNETs - `yc vpc subnet list`

Set TF and YC env:
```bash
export YC_TOKEN=$(yc iam create-token)
export YC_FOLDER_ID=$(yc config get folder-id)
export TF_VAR_folder_id=$(yc config get folder-id)

# export YC_ZONE="<зона_доступности>"                   # NOT REQUIRED, AUTO CHOICE IN PACKER
# export YC_SUBNET_ID="<идентификатор_подсети>"         # NOT REQUIRED, AUTO CREATING IN PACKER
# export YC_TOKEN=$(yc config get token)                # NOT USE IT! USE IAM TOKEN
# export YC_CLOUD_ID=$(yc config get cloud-id)          # FOR TESTING USE
# export PKR_VAR_folder_id=$(yc config get folder-id)   # FOR TESTING USE

```

## Packer: Creating image
Go to Packer folder and Let's go build image
```bash
cd packer
packer init nginx.pkr.hcl
packer build -var "image_tag=1" .
```
Note: Image's name in YC must be format `name-1123` only, ".", "_" - not allowed.\
Name been set in variable `image_name`, but you may override it. 

Check for image created
```bash
yc compute image list
```


More details can be found in the YC docs:
https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-custom-image



## Terraform: apply infrastructure
Deploy your infrastructure to the Yandex Cloud
```bash
cd ../terraform
terraform init
terraform apply #-auto-approve
```

Get loadbalancer ip
```bash
yc application-load-balancer load-balancer list --format json | \
jq ".[0].listeners[0].endpoints[0].addresses[0].external_ipv4_address.address"

```

Checking loadbalancer 
```bash
curl $(terraform output -raw loadbalancer_external_ip):443 -i 
```


How get ssh-keys
```bash
terraform output -raw private_ssh_key > path/key
chmod 600 key
```

Destroy all after testing
```bash
terraform destroy -auto-approve
```

---



