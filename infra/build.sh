#!/bin/bash
set -e

echo "----------< inicio >------------"
# configura o acesso da aws
aws configure

# executa o terraform para criacao da instancia ec2 e infra basica
cd ./terraform
terraform init
terraform apply -var "user_public_key=$(cat ~/.ssh/id_rsa.pub)" -var "aws_vpc=vpc-e346cf9e" -var "aws_region=us-east-1"

# salva o ip publico da instancia criada
export HOST_IP=$(terraform output --raw instance_public_ip_addr)

# instala as collections utilitarias do ansible
cd ../ansible
ansible-galaxy collection install community.general community.postgresql

# Configura o arquivo de host com o ip do servidor criado
sed -e "s/<host_ip>/$HOST_IP/g" ./inventory/hosts.yml > ./final_hosts.yml

# executa o ansible para instalacao e configuracao de software no servidor
ansible-playbook ./main.yml -i final_hosts.yml

echo "teste da aplicação em http://$HOST_IP:8081/case-devops "
echo "-----------< fim >-------------"