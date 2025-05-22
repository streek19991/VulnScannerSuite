#!/bin/bash

TARGET=$1
OUTPUT=output/$(echo $TARGET | tr '/' '_' | tr ':' '_')

mkdir -p $OUTPUT

echo "[*] Iniciando scanner em: $TARGET"

echo "[*] Subdomain enum..."
subfinder -d $TARGET -o $OUTPUT/subdomains.txt

echo "[*] Testando hosts vivos..."
cat $OUTPUT/subdomains.txt | httpx -o $OUTPUT/hosts_alive.txt

echo "[*] Escaneando portas..."
nmap -Pn -T4 -p- -oN $OUTPUT/nmap.txt $TARGET

echo "[*] Buscando diretórios..."
python3 dirsearch/dirsearch.py -u $TARGET -e php,html,js,txt -o $OUTPUT/dirsearch.txt

echo "[*] Detectando tecnologias..."
whatweb $TARGET > $OUTPUT/whatweb.txt

echo "[*] Rodando Nikto..."
nikto -h $TARGET -output $OUTPUT/nikto.txt

echo "[*] Rodando sqlmap..."
sqlmap -u $TARGET --batch --random-agent --threads=5 --output-dir=$OUTPUT/sqlmap

echo "[*] Rodando Nuclei..."
nuclei -u $TARGET -o $OUTPUT/nuclei.txt

echo "[*] Coletando URLs (gau)..."
echo $TARGET | gau > $OUTPUT/gau.txt

echo "[*] Coletando URLs (wayback)..."
echo $TARGET | waybackurls > $OUTPUT/wayback.txt

echo "[*] Rodando XSStrike..."
xsser -u $TARGET -o $OUTPUT/xsser.txt

echo "[*] Finalizado. Resultados em: $OUTPUT"
