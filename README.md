# Personal VPN
## Shadowsocks+V2Ray-plugin

## 0. Project creation

Deployment requires registration of a heroku account, a email is required when registering a heroku account (otherwise the verification code cannot be brushed out). 

An email address that can receive verification codes normally (@qq.com, @163.com are not acceptable):
- gmail (Best) 
- Outlook <https://login.live.com/> here.
 
Note that your account might be terminated when deploying VPN - use at your own risk

Create empty project with any name.

## 2. Configuration

Edit file `ss.Dockerfile`

Replace `PASSWORD`, `QR_PATH` and `V2_PATH` with random string, e.g. from command `cat /dev/random|head -c 128|md5sum`

Replace `APP_NAME` with Heroku project name.

## 2. Building containers

Heroku CLI container `podman build .-f heroku.Dockerfile -t heroku-cli `

Shadowsocks container `podman build . -f ss.Dockerfile -t ss`

## Deployment
 
Login to container registry `podman login registry.heroku.com`. Login `_`, password is API token from settings.

Push `podman push -f v2s2 ss registry.heroku.com/smart-sas/web`

Deploy container
1. `podman run -it --rm heroku-cli`
2. `heroku login`
3. `heroku container:release web -a <project name>`

After the server is deployed, open app to display the webpage normally. After the address is filled with the path (for example: <https://test.herokuapp.com/static>), the 403 page is displayed, which means the deployment is successful.

## 2. Client Configuration

QR code address: https://<project name>.herokuapp.com/<V2_PATH>/vpn.png

Use the client (Shadowsocks recommended) to scan the QR code.

**or**

Use Configuration file -> Address: https://<project name>.herokuapp.com/<V2_PATH>/


Copy the details after opening and import it to the client.

**or**

Manual configuration:

```sh
Server: <project name>.herokuapp.com
Port: 443
Password: <PASSWORD>
Encry Method: chacha20-ietf-poly1305
Plugin: v2ray
Plugin Transport mode: websocket-tls
Hostname: Same as Server
Path: "/" + value of V2_Path 
```

Those without a client can also download from here (Android):

[shadowsocks](https://github.com/shadowsocks/shadowsocks-android/releases/latest/download/shadowsocks--universal-5.1.9.apk)

[v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin-android/releases/latest/download/v2ray-arm64-v8a-1.3.1.apk)

windows:

<https://github.com/shadowsocks/shadowsocks-windows/wiki/Shadowsocks-Windows-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E>

# Reference

https://github.com/ygcaicn/ss-heroku

https://github.com/xiangrui120/v2ray-heroku-undone

https://hub.docker.com/r/shadowsocks/shadowsocks-libev

https://github.com/shadowsocks/v2ray-plugin
