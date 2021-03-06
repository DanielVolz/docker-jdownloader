![logo](logo.png "logo")

JDownloader - Docker Image
==========================

[![latest release](https://img.shields.io/github/release/jaymoulin/docker-jdownloader.svg "latest release")](http://github.com/jaymoulin/docker-jdownloader/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/jaymoulin/jdownloader.svg)](https://hub.docker.com/r/jaymoulin/jdownloader/)
[![Docker stars](https://img.shields.io/docker/stars/jaymoulin/jdownloader.svg)](https://hub.docker.com/r/jaymoulin/jdownloader/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jaymoulin/rpi-jdownloader.svg)](https://hub.docker.com/r/jaymoulin/rpi-jdownloader/)
[![Docker stars](https://img.shields.io/docker/stars/jaymoulin/rpi-jdownloader.svg)](https://hub.docker.com/r/jaymoulin/rpi-jdownloader/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)
[![Watch Ads](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/utip.png "Watch Ads")](https://utip.io/femtopixel)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)
[![Become a Patron](https://badgen.net/badge/become/a%20patron/F96854 "Become a Patron")](https://patreon.com/femtopixel)


This image allows you to have JDownloader daemon installed easily thanks to Docker.

Installation
---

```
docker run -d --init --restart=always -v ~/Downloads:/root/Downloads -v ~/jdownloader/cfg:/opt/JDownloader/cfg --name jdownloader -u $(id -u) jaymoulin/jdownloader
```

You can replace `~/Downloads` with the folder you want your downloaded files to go.

It is recommended to add `-v ~/jdownloader/cfg:/opt/JDownloader/cfg` to your command to save all your configurations.
Note: Use the `-u $(id -u)` part for jdownloader to run as a specific user. It's recommanded to use static values (see: https://docs.docker.com/engine/reference/commandline/exec/#options)
Note: Add `-p 3129:3129` to allow Jdownloader direct connections (this has to be forwared in your router) (see: https://support.jdownloader.org/Knowledgebase/Article/View/33/0/myjdownloader-advanced-settings)

*Note for RPI Zero* : specify that you want the arm32v6 image (e.g. jaymoulin/jdownloader:0.7.0-arm32v6) because rpi zero identify itself as armhf which is wrong.

Configuration
---

You must configure your MyJDownloader login/password with this command :

```
docker exec jdownloader configure email@email.com password
```

Everything else can be configurable on your MyJDownloader account : https://my.jdownloader.org/index.html#dashboard

Appendixes
---

### Direct Connection

As @jiaz83 stated

> short explanation what the direct connection mode does.
> client(app,webinterface,tool...)<-....->JDownloader connections happens either
> 
> 1.) client<-apiserver->JDownloader
> in this(default,fallback) mode both(control- and data-) connections are using the api server.
> Advantage: no need to forward ports/dyndns
> Disadvantage: lower bandwidth and higher latency
> 
> 2.) client<->JDownloader
> in this (direct connection) mode, control connections are still using the api server while data connections are directly connecting to the running JDownloader instance without any relay server
> Advantage: much higher bandwidth and reduced latency
> Disadvantage: user might have to manually enable/allow port forwarding from LAN and/or WAN IP to JDownloader instance
> On connection issues, the client will automatically fallback to 1.) and try to re-establish a direct connection again.
> 
> by default direct connection mode is set to LAN, so only clients from LAN can connect directly.
> see https://support.jdownloader.org/Knowledgebase/Article/View/33/0/myjdownloader-advanced-settings
> default port is 3129


### Install Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/0e650b38fde684c4ac534b254099d6d5543375f1/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```
