[ ! $ENV_FLAG ]  && echo "Bad env!" && exit 1
[ ! $1 ] && echo "Error: user name required." && exit 1
useradd -d $PUBLIC_HOME/$1 -G wheel -N -pustc-isc2016  -s /bin/bash $1 && sync-passwd.sh
# chcon -R -tssh_home_t /public/home/$1/.ssh  # Oh, terrible SELinux!

