#!/bin/bash
# DUCK BANNER - Instalador estilo CyberMux
# Uso: bash install.sh
#      bash install.sh "Tu Apodo"
#      curl -sL https://raw.githubusercontent.com/TU-USUARIO/duck-banner/main/install.sh | bash -s "Tu Apodo"

set -e
GREEN='\033[1;32m'; CYAN='\033[1;36m'; YELLOW='\033[1;33m'; MAGENTA='\033[1;35m'; NC='\033[0m'

echo -e "${CYAN}🦆 DUCK BANNER - Instalador${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

INSTALL_DIR="$HOME/.duck-banner"
CONFIG_DIR="$HOME/.config/duck-banner"
CONFIG_FILE="$CONFIG_DIR/config"
BIN_DIR="$HOME/.local/bin"

# 1. Apodo - argumento, o pregunta si no viene
NICK="$1"
if [ -z "$NICK" ]; then
  if [ -f "$CONFIG_FILE" ]; then
    # shellcheck disable=SC1090
    source "$CONFIG_FILE" 2>/dev/null || true
    NICK="$NICKNAME"
  fi
fi
if [ -z "$NICK" ]; then
  read -p "✦ Escribe tu apodo (ej: Ghost, KaliKid): " NICK
  if [ -z "$NICK" ]; then NICK="DUCK USER"; fi
fi

# 2. Crear carpetas
mkdir -p "$INSTALL_DIR" "$CONFIG_DIR" "$BIN_DIR"

# 3. Copiar archivos - funciona si lo corres desde git clone o desde curl (descarga si falta)
SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)"
if [ -f "$SCRIPT_DIR/duck-banner.sh" ]; then
  cp "$SCRIPT_DIR/duck-banner.sh" "$INSTALL_DIR/duck-banner.sh"
else
  echo "Descargando duck-banner.sh desde GitHub..."
  if command -v curl >/dev/null 2>&1; then
    curl -sL "https://raw.githubusercontent.com/TU-USUARIO/duck-banner/main/duck-banner.sh" -o "$INSTALL_DIR/duck-banner.sh"
  else
    wget -q "https://raw.githubusercontent.com/TU-USUARIO/duck-banner/main/duck-banner.sh" -O "$INSTALL_DIR/duck-banner.sh"
  fi
fi
if [ -f "$SCRIPT_DIR/uninstall.sh" ]; then
  cp "$SCRIPT_DIR/uninstall.sh" "$INSTALL_DIR/uninstall.sh"
fi
chmod +x "$INSTALL_DIR/duck-banner.sh"

# 4. Guardar config con apodo
cat > "$CONFIG_FILE" <<EOF
# DUCK BANNER - Config
# Cambia tu apodo con: duck-nick "Tu Apodo"
NICKNAME="$NICK"
MODE="neon"
EOF

# 5. Crear comandos faciles
cat > "$BIN_DIR/duck" <<'EOF'
#!/bin/bash
bash "$HOME/.duck-banner/duck-banner.sh" "$@"
EOF
cat > "$BIN_DIR/duck-nick" <<'EOF'
#!/bin/bash
# Uso: duck-nick "Tu Apodo"
if [ -z "$1" ]; then
  echo "Uso: duck-nick \"Tu Apodo\""
  echo "Apodo actual: $(grep NICKNAME "$HOME/.config/duck-banner/config" | cut -d'"' -f2)"
  exit 1
fi
mkdir -p "$HOME/.config/duck-banner"
# Reemplaza NICKNAME sin tocar MODE
if grep -q "^NICKNAME=" "$HOME/.config/duck-banner/config" 2>/dev/null; then
  sed -i "s/^NICKNAME=.*/NICKNAME=\"$1\"/" "$HOME/.config/duck-banner/config"
else
  echo "NICKNAME=\"$1\"" >> "$HOME/.config/duck-banner/config"
fi
echo "✅ Apodo cambiado a: $1"
bash "$HOME/.duck-banner/duck-banner.sh"
EOF
cat > "$BIN_DIR/duck-uninstall" <<'EOF'
#!/bin/bash
bash "$HOME/.duck-banner/uninstall.sh"
EOF
chmod +x "$BIN_DIR/duck" "$BIN_DIR/duck-nick" "$BIN_DIR/duck-uninstall"

# 6. Enganchar al inicio de la terminal - sin duplicar
for RC in "$HOME/.bashrc" "$HOME/.zshrc"; do
  # Solo toca el archivo que exista, o .bashrc en Termux
  if [ -f "$RC" ] || [ "$RC" = "$HOME/.bashrc" ]; then
    touch "$RC"
    if ! grep -q "DUCK-BANNER-START" "$RC"; then
      echo "" >> "$RC"
      echo "# DUCK-BANNER-START - No borrar, lo maneja duck-uninstall" >> "$RC"
      echo "if [ -f \"\$HOME/.duck-banner/duck-banner.sh\" ]; then bash \"\$HOME/.duck-banner/duck-banner.sh\" neon; fi" >> "$RC"
      echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$RC"
      echo "# DUCK-BANNER-END" >> "$RC"
      echo -e "${GREEN}✔ Agregado a $RC${NC}"
    else
      echo -e "${YELLOW}• Ya estaba en $RC, no se duplicó${NC}"
    fi
  fi
done

echo ""
echo -e "${GREEN}✅ INSTALADO!${NC}"
echo -e "Apodo: ${MAGENTA}$NICK${NC}"
echo ""
echo "Comandos:"
echo "  duck                -> ver el pato cuando quieras"
echo "  duck-nick \"Ghost\"   -> cambiar apodo en 1 segundo"
echo "  duck-uninstall      -> desinstalar todo limpio"
echo ""
echo "Cierra y abre Termux / Kali para verlo al inicio."
bash "$INSTALL_DIR/duck-banner.sh" neon
