#!/bin/bash


#
#
#	Script permettant la création des utilisateurs à partir du fichier texte (users_messagerie_$DATE.sh) généré sur l'ancien serveur
#
#


#File name with date only
DATE=$(date +"%F")

#Files locations
input="/tmp/users_messagerie_$DATE.txt"
output="/tmp/users_creation_$DATE.sh"
output1="/tmp/users_password_$DATE.sh"

#Set the shell
echo "#!/bin/sh -x" >>  $output
echo "su zimbra" >>  $output

echo "#!/bin/sh -x" >>  $output1
echo "su zimbra" >>  $output1

# Loop in the File to get EMAIL INFORMATIONS
while IFS=';' read -r email name password
do
  echo "zmprov ca "$email" dsfs123hsdyfgbsdgfbsd displayName '"$name"'" >>  $output
  echo "zmprov ma "$email" userPassword '{crypt}"$password"' " >>  $output
  echo "zmprov ma "$email" userPassword '{crypt}"$password"' " >>  $output1
done < "$input"

echo "exit" >>  $output
echo "exit" >>  $output1

chmod +x "/tmp/users_creation_$DATE.sh"
chmod +x "/tmp/users_password_$DATE.sh"

cd /tmp/
./users_creation_$DATE.sh
./users_password_$DATE.sh
