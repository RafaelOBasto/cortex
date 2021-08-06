#!/bin/bash
set -e

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo " "
echo "  ${green}*** Iniciando o backup do banco de dados ***${reset} "
echo " "

echo -n "- Criando o diretório: /opt/backups....."
mkdir -p /opt/backups
chown postgres:postgres -R /opt/backups
echo "${green}[ok]${reset}"
echo " "

cd /opt/backups

echo -n "- Parando o servico do jetty............"
service jetty stop
echo "${green}[ok]${reset}"
echo " "

echo -n "- Efetuando o dump do database.........."
DUMP_NAME="cortex-backup-$(date '+%Y-%m-%d-%H')"
sudo -u postgres pg_dumpall > $DUMP_NAME
echo "${green}[ok]${reset}"
echo " "

echo -n "- Iniciando o servico do jetty.........."
service jetty start
echo "${green}[ok]${reset}"
echo " "

echo -n "- Gerando o arquivo de dump zipado......"
sudo -u postgres tar -czf "$DUMP_NAME.sql" $DUMP_NAME
echo "${green}[ok]${reset}"
echo " "

echo -n "- Apagando o arquivo de dump original..."
rm -f $DUMP_NAME
echo "${green}[ok]${reset}"
echo " "
echo "- Arquivo gerado --> $DUMP_NAME.sql"
echo " "
echo "  ${green}*** Backup efetuado com sucesso ***${reset} "
echo " "
