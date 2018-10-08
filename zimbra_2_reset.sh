#!/bin/bash

#Files locations

DATE=$(date +"%F")

input="/tmp/users_messagerie_$DATE.txt"
output="/tmp/reset_pwd_$DATE.sh"

# Headers
echo "#!/bin/bash" >>  $output

# Loop in the File to get EMAIL INFORMATIONS
while IFS=';' read -r email name password
do
  echo "zmprov sp "$email" zimbra" >>  $output
done < "$input"

echo "exit" >>  $output

chmod +x $output

cd /tmp/
#./reset_pwd_$DATE.sh
