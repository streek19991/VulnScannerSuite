#!/bin/bash

echo "[*] Instalando ferramentas básicas..."
sudo apt update && sudo apt install -y nmap nikto sqlmap masscan whatweb wpscan xsser python3-pip git curl

echo "[*] Instalando ferramentas via Git..."
git clone https://github.com/projectdiscovery/nuclei.git
cd nuclei && go install && cd ..

git clone https://github.com/ffuf/ffuf.git
cd ffuf && go install && cd ..

git clone https://github.com/projectdiscovery/subfinder.git
cd subfinder && go install && cd ..

git clone https://github.com/projectdiscovery/httpx.git
cd httpx && go install && cd ..

git clone https://github.com/maurosoria/dirsearch.git

git clone https://github.com/tomnomnom/gau.git
cd gau && go install && cd ..

git clone https://github.com/tomnomnom/waybackurls.git
cd waybackurls && go install && cd ..

git clone https://github.com/hakluke/hakrawler.git
cd hakrawler && go install && cd ..

echo "[*] Instalação concluída!"
