<p align="left">
  <a href="https://github.com/vdarkobar/npm">Home</a>
  <br><br>
</p> 
  
# Authelia
*Authelia (Lite) - Self-Hosted Single Sign-On and Two-Factor Authentication.*
  
Login to <a href="https://dash.cloudflare.com/">CloudFlare</a> and set *Subdomain* for Authelia.

```
    CNAME | subdomain | @ (or example.com)
```
example:
```
    CNAME | auth | @ (or example.com)
```
---
  
Setup <a href="https://accounts.google.com/signin/v2/identifier?flowName">Gmail account</a> for Authentification Notifier service. Create <a href="https://myaccount.google.com/u/1/apppasswords">App-Password</a> for Authelia. 
  
#### *Decide what you will use for*:
```
Time Zone,
Authelia and Redis Port Nummber (default values hint provided),
Domain name to protect and Authelia Subomain (recomended: auth)
Authentification Notifier Email and Password (Gmail), 
Authelia Administrator Username, Displayname, Emailand and Password.
```
  
### *Run this command*:
```
RED='\033[0;31m'; echo -ne "${RED}Enter directory name: "; read DIR; \
mkdir -p "$DIR"; cd "$DIR" && git clone https://github.com/vdarkobar/Authelia.git . && \
chmod +x setup.sh && \
./setup.sh
```

### Log:
```
sudo docker-compose logs authelia
sudo docker-compose logs authelia-db
sudo docker logs -tf --tail="50" authelia
sudo docker logs -tf --tail="50" authelia-db
```  
  
### Follow <i><a href="https://github.com/vdarkobar/NPM/blob/main/shared/Authelia%20Additional%20Settings.md">this link</a></i> for important additional Authelia settings.  
