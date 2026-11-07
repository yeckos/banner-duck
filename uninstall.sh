#!/bin/bash
# DUCK BANNER - Desinstalador limpio
# Uso: bash uninstall.sh  o  duck-uninstall

RED='\033[1;31m'; GREEN='\033[1;32m'; CYAN='\033[1;36m'; NC='\033[0m'
echo -e "${CYAN}🦆 DUCK BANNER - Desinstalando...${NC}"

# 1. Quitar del .bashrc y .zshrc (solo el bloque marcado)
for RC in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$RC" ] && grep -q "DUCK-BANNER-START" "$RC"; then
    # Borra desde START hasta END inclusive
    sed -i '/# DUCK-BANNER-START/,/# DUCK-BANNER-END/d' "$RC"
    echo -e "${GREEN}✔ Quitado de $RC${NC}"
  fi
done

# 2. Borrar archivos del pato
rm -rf "$HOME/.duck-banner"
rm -rf "$HOME/.config/duck-banner"
rm -f "$HOME/.local/bin/duck" "$HOME/.local/bin/duck-nick" "$HOME/.local/bin/duck-uninstall"

echo ""
echo -e "${GREEN}✅ Desinstalado por completo.${NC}"
echo "Tu .bashrc / .zshrc quedó limpio, sin tocar nada más."
echo "Cierra y abre la terminal para comprobarlo."
