#!/bin/sh

mysql_root_passwd=`test -f /root/.tuleap_passwd && grep -i "Mysql root" /root/.tuleap_passwd | cut -d: -f2 | tr -d ' '`
    
if [ ! -z "$mysql_root_passwd" ]; then
  mysql --password=$mysql_root_passwd \
    -e "UPDATE mysql.user SET Password=PASSWORD('') WHERE user='root'; FLUSH PRIVILEGES;"
fi

yes | /usr/share/tuleap-install/setup.sh \
      --sys-default-domain   tuleap.local \
      --sys-fullname         tuleap.local \
      --disable-subdomains   \
      --sys-ip-address       10.11.13.11 \
      --sys-org-name         Tuleap \
      --sys-long-org-name    "Tuleap ALM" \
      --auto-passwd \
  2>&1 | tee /var/log/tuleap-install.log
