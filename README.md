# 🦆 DUCK BANNER v4 

Instalador para Kali Linux + Termux. Se instala, se queda puesto al abrir la terminal, apodo fácil y desinstalación limpia.

## 🚀 Instalar en 1 comando

### Desde GitHub (Termux / Kali)

```bash
git clone https://github.com/yeckos/duck-banner.git
cd duck-banner
bash install.sh "Tu Apodo"
```

### Sin clonar, directo con curl

```bash
curl -sL https://raw.githubusercontent.com/yeckos/duck-banner/main/install.sh | bash -s "Tu Apodo"
```

Te va a preguntar tu apodo si no lo pones. Si ya lo tenías, lo conserva.

## ✨ Qué hace el instalador

1. Copia el pato a `~/.duck-banner/`
2. Guarda tu apodo en `~/.config/duck-banner/config`
3. Crea los comandos `duck`, `duck-nick`, `duck-uninstall` en `~/.local/bin/`
4. Agrega el banner a `~/.bashrc` y `~/.zshrc` con marcadores, sin duplicar

## 🎭 Comandos

```bash
duck                    # ver el pato cuando quieras
duck neon               # versión neón
duck classic            # versión colores originales
duck --no-color         # solo letras y números
duck-nick "Ghost"       # cambiar apodo en 1 segundo
duck-uninstall          # desinstalar todo limpio
```

## ✦ Cambiar apodo

```bash
duck-nick "KaliKid"
```

O edita el archivo:

```bash
nano ~/.config/duck-banner/config
# NICKNAME="KaliKid"
# MODE="neon"
```

## 🗑️ Desinstalar

```bash
duck-uninstall
# o
bash uninstall.sh
```

Borra:
- `~/.duck-banner/`
- `~/.config/duck-banner/`
- Los 3 comandos en `~/.local/bin/`
- Solo el bloque del pato en `.bashrc` / `.zshrc`, sin tocar nada más

## 📦 Archivos

| Archivo | Para qué |
|---------|----------|
| `install.sh` | Instalador estilo CyberMux |
| `uninstall.sh` | Desinstalador limpio |
| `duck-banner.sh` | El pato v4, 64 cols, centrado, lee apodo de config |
| `duck.sh` / `duck-neon.sh` | Versiones viejas v1 / v2 |
| `README.md` | Este archivo |

## 📄 Licencia

MIT
