# Authelia
Authelia (Lite) - Self-Hosted Single Sign-On and Two-Factor Authentication

setup domain and auth CNAME for Authelia subdomain,  
setup gmail account for notifier service (DUO?, pogledati authelia doc za ostale)

### *Run this command*:
```
RED='\033[0;31m'; echo -ne "${RED}Enter directory name: "; read DIR; \
mkdir -p "$DIR"; cd "$DIR" && git clone https://github.com/vdarkobar/Authelia.git . && \
chmod +x setup.sh && \
./setup.sh
```
