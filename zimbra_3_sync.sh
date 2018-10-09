#!/bin/bash

DATE=$(date +"%F")
FILE="users_password_$DATE.sh"
HOST1="X.X.X.X"
HOST2="Y.Y.Y.Y"
PORT2="ABCD"
input="/tmp/users_messagerie_$DATE.txt"
input1="/tmp/synchronisation_$DATE.log"

#Synchronisation de mails
echo "Début synchronisation vers le serveur Zimbra" >> $input1
while IFS=';' read -r email name password
do
 echo "....Début Synchronisation utilisateur $email"  >> $input1
 imapsync --buffersize 8192000 --nosyncacls --subscribe --syncinternaldates --host1 $HOST1 --user1 $email --password1 zimbra --noauthmd5 --host2 $HOST2 --user2 $email --password2 zimbra --ssl2 --port2 $PORT2

 echo "....Fin Synchronisation utilisateur $email"  >> $input1
done < "$input" 

echo "Fin synchronisation vers le serveur Zimbra"  >> $input1

echo " " >> $input1
echo " " >> $input1

#Reset passwords to users Password

echo "Début modification mot de passe utilisateurs" >> $input1

while IFS=';' read -r email name password
do
 echo "....Début modification mot de passe utilisateur $email"  >> $input1
 imapsync --buffersize 8192000 --nosyncacls --subscribe --syncinternaldates --host1 $HOST1 --user1 $email --password1 zimbra --noauthmd5 --host2 $HOST2 --user2 $email --password2 zimbra --ssl2 --port2 $PORT2

 echo "....Fin modification mot de passe utilisateur $email"  >> $input1
done < "$input"

echo "Fin modification mot de passe utilisateurs"  >> $input1

cd /tmp/
./users_password_$DATE.sh
