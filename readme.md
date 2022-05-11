# References

1. Self signed SSL[https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/]
   - Here's the tutorial. here[https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04]
   - on Ubuntu 20[https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04]
   - renewal process
   ```
   sudo certbot renew --dry-run
   ```
   -- execute via docker compose
   ```
   docker-compose run --rm --entrypoint "certbot renew --dry-run" certbot
   ```
   - Pentacent Medium [https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71]
2. What is build-essential package ? [https://linuxize.com/post/how-to-install-gcc-on-ubuntu-20-04]
3. Setup Nginx [https://www.nginx.com/blog/setting-up-nginx/]
4. Setup Timezone first if you are interrupted on installing nginx on docker
   ```
   timedatectl set-timezone UTC
   ```
5. Setup UFW Ubuntu[https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04]
   - Enable UFW[https://askubuntu.com/questions/30781/see-configured-rules-even-when-inactive]
6. Alpine User Command[https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/]
   - Service status list
     ```
         rc-status --servicelist
     ```
7. FIXED: This is WHY Wordpress doing infinite loop when we put wordpress behind reverse proxy that doesn't have SSL[link](https://wordpress.stackexchange.com/questions/250240/setting-serverhttps-on-prevents-access-to-wp-admin)
8. PHP FPM Running as user nobody ?? LOL [link](https://serverfault.com/questions/617392/why-is-php-fpm-running-as-nobody)

# Docker File Structure

1. dependency: modular script to build an image
2. config: mounted to container, store config for every module on running
3. script: commands to run after container running

# ! Update your server user data

1. Add group webuser

```
groupadd webuser
```

2. Assign www-data to webuser

```
usermod -a www-data -G webuser
```

# ! INDESCRIBABLE ERROR POSSIBILITY XD

1. Directory is not exist yet
2. Permisson issue
3. Firewall issue
4. Config must be cached (?)

# !MySQL settings

1. Make MySQL listen to all interface [https://www.garron.me/en/bits/mysql-bind-all-address.html] - hmm it should only listen to docker0 interface
   - reason[https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach]

```
# bind-address		= 127.0.0.1
bind-address		= 0.0.0.0
```

# Questions

1. Why cannot assign host port on network host in docker compose yaml ?
2. Why nginx viewed as "Crashed" but it is actually running on Alpine docker container ?
   - i have to restart php-fpm8 and nginx again hmmm
