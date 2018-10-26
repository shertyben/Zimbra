#!/bin/bash
MYSQLHOST="localhost"
MYSQLDB="database"
MYSQLUSER="user"
MYSQLPASS="pass"
 
#File name with date only
DATE=$(date +"%F")
 
#File location
FILE="/tmp/users_messagerie_$DATE.txt"
 
MYSQLOPTS="--user=${MYSQLUSER} --password=${MYSQLPASS} --host=${MYSQLHOST} ${MYSQLDB}"
 
echo "Début Report : $(date)"

#Dump username and password to file 
mysql ${MYSQLOPTS} << EOFMYSQL
SELECT email , REPLACE ( name, "'", "") , password  FROM comptes WHERE etat=1 INTO OUTFILE '$FILE' FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';
EOFMYSQL

# Set Password to default in order to sync mails
#mysql ${MYSQLOPTS} << EOFMYSQL
#UPDATE comptes SET password=encrypt('zimbra');
#COMMIT;
#EOFMYSQL
 
#add column title to the report
#sed -i '1i email,name,password' $FILE

echo "Fin Report : $(date)"

echo "Après la fin de l'export, copier ce script sur le serveur Zimbra, puis éxecuter la suite des scripts shell"
echo "Merci pour l'exploitation du script"
