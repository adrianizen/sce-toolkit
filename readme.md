# References
1. Self signed SSL[https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/]
2. What is build-essential package ? [https://linuxize.com/post/how-to-install-gcc-on-ubuntu-20-04]
3. Setup Nginx [https://www.nginx.com/blog/setting-up-nginx/]
4. Setup Timezone first if you are interrupted on installing nginx on docker
    ```
    timedatectl set-timezone UTC
    ```
5. Setup UFW Ubuntu[https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04]
6. Alpine User Command[https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/]
    - Service status list
        ```
            rc-status --servicelist
        ```


# Docker File Structure
1. dependency: modular script to build an image
2. config: mounted to container, store config for every module on running
3. script: commands to run after container running


# Questions
1. Why cannot assign host port on network host in docker compose yaml ?
2. Why nginx viewed as "Crashed" but it is actually running on Alpine docker container ?