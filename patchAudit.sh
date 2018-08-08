#! /bin/bash

# Used to gather information about linux systems including
# list of current patches and OS version.
# Can be used with one IP or multiple IPs.
#
# Method: ./patchAudit.sh <IP> [IP IP ...]

#Add param checking
case $1 in
        -[h?] | --help)
        echo "Params: <IP> [IP IP ...]"
        echo "Ex: ./patchAudit.sh 192.168.1.8 192.168.1.9"
        exit 1
        ;;
esac

mkdir $HOME/patchaudit-collection
echo "Ssh as: "
read USER

IPS=("$@")

for ((i=0; i < $#; i++))
{
  IP="${IPS[$i]}"
  ssh "$USER"@"$IP" << EOF
        echo "OS Version" > /tmp/patchaudit-"$IP".log
        lsb_release -a >> /tmp/patchaudit-"$IP".log
        echo "" >> /tmp/patchaudit-"$IP".log
        echo "Installed Patches" >> /tmp/patchaudit-"$IP".log
        sudo apt list --installed >> /tmp/patchaudit-"$IP".log
EOF
  /usr/bin/scp "$USER"@"$IP":/tmp/patchaudit-"$IP".log $HOME/patchaudit-collection
}
