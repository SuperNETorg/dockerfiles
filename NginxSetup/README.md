## SETUP NGINX and Letsencrypt for Jenkins reverse proxy
This script assumes that nginx and letsencrypt is not installed on server.
To setup NGINX with letsencrypt on a given node/server run shell/bash script `setup_nginx.sh` in terminal. Follow the below instructions: 
- Go to `NginxSetup` directory using terminal.
- Make script executable by running command `chmod -f u+x setup_nginx.sh`
- Run the script by running command `./setup_nginx.sh`


### Additional Setup to be done manually
Letsencrypt's certificates are valid for 90 days, it is recommended to renew certificates after 60 days. To update all expired setup automatically setup cron job as described below:
- Run command `sudo crontab -e` and select desired editor by pressing respective number key, this will open a cron tab file
- Apped following lines 
```
30 2 * * 1 /opt/letsencrypt/letsencrypt-auto renew >> /var/log/le-renew.log
35 2 * * 1 /etc/init.d/nginx reload
```
- Save and exit the editor 

This will enable cron job to automatically update expired certificates 
