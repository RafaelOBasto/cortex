# Desafio Cortex

Desafio de DevOps da Cortex:

## Objetivo:

Craiar uma infraestrutura básica na AWS com uma instancia EC2 com:
- SO Ubuntu 18.04 LTS
- Java 8 SDK
- PostgreSQL 9.6
- Jetty 9.4.26 (Diponibilizado no repositório)
- WAR da aplicação case-devops.war (Diponibilizado no repositório)


## Pré-requisitos

Instalação das seguintes ferramentas:
- Python 3.8
- Ansible core 2.11.3
- Terraform v1.0.3
- aws-cli 2.2.25

## Roteiro de criação da infraestrutura

Na pasta infra do projeto executar o script build.sh

```
cd infra
chmod 770 build.sh
./build.sh
```
Será solicitado as configurações de acesso da AWS:

```
AWS Access Key ID []: 
AWS Secret Access Key []: 
Default region name []: 
Default output format [None]: 
```

Na execução do terraform, informe o aws_vpc_id quando solicitado.
Após a exibição do plano de mudança do terraform, digite yes para executa

No final será exibido a URL do app server criado para teste.
