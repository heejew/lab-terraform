

# Preparing for blocked country
```bash
cp .terraformrc ~
```

# Packer: Creating image
Для работы потребуется установленный и настроенный yc cli ([Как установить yc cli](https://cloud.yandex.com/en/docs/cli/operations/install-cli)). 
Без него - как-нибудь сами через UI ;)

Переходим в папку
```bash
cd packer
```


Устанавливаем переменные для работы пакера
```bash
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_ZONE="<зона_доступности>"
export YC_SUBNET_ID="<идентификатор_подсети>"
export YC_TOKEN=$(yc config token)

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export TF_VAR_folder_id=$(yc config get folder-id)
```

Получить доступные ZONE - `yc compute zone list`\
Получить доступные SUBNET - `yc vpc subnet list`

"ru-central1-a"
"e9bb3mls44fadqh6l9oq"

Билдим Image
```bash
packer build -var "image_tag=1" nginx.pkr.hcl
```
Примечание: В именах образов в YC можно засунуть только name-1, ни ".", ни "_" недопускаются

Проверяем, что image создался
```bash
yc compute image list
```


Более детально можно почитать в документации YC
https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-custom-image



# Terraform: apply infrastructure
Deploy your infrastructure to the Yandex Cloud
```bash
cd ../terraform
terraform init
terraform apply -auto-approve
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
terraform output -raw private_ssh_key > some_path/key_name
chmod 600 key_name
```

---




