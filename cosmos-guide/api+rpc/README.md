# Guide Create RPC API Node Cosmos

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

# Prepare : 
- Domain and Subdomain


## Setting api in app.toml

<p align="center">
  <img style="margin: auto; height: auto;" src="https://user-images.githubusercontent.com/65535542/215301089-2477d432-005b-4505-a3d2-28976ddd1d6c.png">
</p>

```bash
nano $HOME/.planqd/config/app.toml
```

## Install Package

```bash
sudo apt autoremove nodejs -y
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install nginx certbot python3-certbot-nginx nodejs git yarn -y 
```

## Setting Proxy nginx and Install SSL

### Cek API and RPC IP:PORT


```bash
 nano $HOME/.planqd/config/app.toml
 ```

 <p align="center">
  <img style="margin: auto; height: auto;" src="https://user-images.githubusercontent.com/65535542/215300888-5fe0d7da-ef16-4f86-b9be-81af01f26058.png">
</p>


```bash
 nano $HOME/.planqd/config/config.toml
 ```
<p align="center">
  <img style="margin: auto; height: auto;" src="https://user-images.githubusercontent.com/65535542/215300949-42bb29cc-116d-483d-a512-a4c29fb325d1.png">
</p>


- Set API Domain
```bash
API_DOMAIN="YOUR_API_DOMAIN"
```

- Set API Port
```bash
API_IP_PORT="IP:PORT"
```

- Set RPC Domain
```bash
RPC_DOMAIN="YOUR_API_DOMAIN
```

- Set RPC Port

```bash
RPC_IP_PORT="IP:PORT"
```


### Create Config

### Create API Config
```bash
sudo cat <<EOF > /etc/nginx/sites-enabled/${API_DOMAIN}.conf
server {
    server_name $API_DOMAIN;
    listen 80;
    location / {
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Max-Age 3600;
        add_header Access-Control-Expose-Headers Content-Length;

	proxy_set_header   X-Real-IP        \$remote_addr;
        proxy_set_header   X-Forwarded-For  \$proxy_add_x_forwarded_for;
        proxy_set_header   Host             \$host;

        proxy_pass http://$API_IP_PORT;

    }
}
EOF
```

### Create RPC Config

```bash
sudo cat <<EOF > /etc/nginx/sites-enabled/${RPC_DOMAIN}.conf
server {
    server_name $RPC_DOMAIN;
    listen 80;
    location / {
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Max-Age 3600;
        add_header Access-Control-Expose-Headers Content-Length;

	proxy_set_header   X-Real-IP        \$remote_addr;
        proxy_set_header   X-Forwarded-For  \$proxy_add_x_forwarded_for;
        proxy_set_header   Host             \$host;
	
	proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_pass http://$RPC_IP_PORT;

    }
}
EOF
```

### Config Test

```bash
sudo pkill nginx
nginx -t 
```

Output if Succes

`nginx: the configuration file /etc/nginx/nginx.conf syntax is ok`

`nginx: configuration file /etc/nginx/nginx.conf test is successful`


### Install Certificate SSL

```bash
sudo certbot --nginx --register-unsafely-without-email
sudo certbot --nginx --redirect -d ${API_DOMAIN},${RPC_DOMAIN}
```
