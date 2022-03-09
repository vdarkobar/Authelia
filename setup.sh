#!/bin/bash
clear
echo -ne "${RED}Enter Time Zone: "; read TZONE; \
echo -ne "${RED}Enter Authelia Port Number (9091): "; read PORTN; \
echo -ne "${RED}Enter Redis Port Number (6379): "; read REDPORT; \
echo -ne "${RED}Enter Domain name: "; read DNAME; \
echo -ne "${RED}Enter Authelia Subomain: "; read SUBDNAME; \
echo -ne "${RED}Enter Authentification Notifier Email: "; read ANEMAIL; \
echo -ne "${RED}Enter Password for Authentification Email (Google App-pass.): "; read -s PASSANEMAIL; \
echo -ne "${RED}Enter Authelia Administrator Username: "; read USERNAME1; \
echo -ne "${RED}Enter Authelia Administrator Displayname: "; read DISPLAYNAME1; \
echo -ne "${RED}Enter Authelia Administrator Email: "; read USEREMAIL1; \
echo -ne "${RED}Enter Authelia Administrator Password: "; read -s AAUPASS; \
SALT=$(openssl rand -base64 32) \
HASHED_PASSWORD=$(echo -n $AAUPASS| argon2 $SALT -k 1024 -t 1 -p 8 -e -id); sed -i "s|CHANGE_HASHED_PASSWORD1|${HASHED_PASSWORD}|" users_database.yml && \
REDIS_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32); sed -i "s|CHANGE_REDIS_PASSWORD|${REDIS_PASSWORD}|" .env && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 63 > secrets/authelia_jwt_secret && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 63 > secrets/authelia_session_secret && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 32 > secrets/authelia_storage_encryption_key && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 32 > secrets/authelia_storage_mysql_password && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 32 > secrets/mysql_root_password && \
sed -i "s|01|${TZONE}|" .env && \
sed -i "s|02|${PORTN}|" .env && \
sed -i "s|03|${REDPORT}|" .env && \
sed -i "s|CHANGE-DOMAINNAME|${DNAME}|" configuration.yml && \
sed -i "s|CHANGE-SUBDOMAIN|${SUBDNAME}|" configuration.yml && \
sed -i "s|CHANGE-EMAIL|${ANEMAIL}|" configuration.yml && \
echo ${PASSANEMAIL} > secrets/authelia_notifier_smtp_password && \
sed -i "s|CHANGE_USERNAME1|${USERNAME1}|" users_database.yml && \
sed -i "s|CHANGE_DISPLAYNAME1|${DISPLAYNAME1}|" users_database.yml && \
sed -i "s|CHANGE-USEREMAIL1|${USEREMAIL1}|" users_database.yml && \
rm README.md && \
sudo chown -R root:root secrets/ && \
sudo chmod -R 600 secrets/ && \
while true; do
    read -p "Execute 'docker-compose up -d' now? (y/n)" yn
    case $yn in
        [Yy]* ) sudo docker-compose up -d; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
