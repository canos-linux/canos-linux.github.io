#!/bin/bash
# Enable CanOS updates (repository [canos]) on CanOS 1.0.
# Usage: curl -sL https://canos-linux.github.io/repo.sh | sudo bash
set -e
[ "$(id -u)" = 0 ] || { echo "Please run with sudo"; exit 1; }
grep -q '^\[canos\]' /etc/pacman.conf || printf '\n[canos]\nSigLevel = Optional TrustAll\nServer = https://github.com/canos-linux/canos-repo/releases/download/x86_64\n' >> /etc/pacman.conf
pacman -Sy --noconfirm --overwrite '/usr/share/canvas/*' --overwrite /usr/bin/canvas --overwrite '/usr/share/canos/*' --overwrite /etc/xdg/mimeapps.list canvas canos-tools
rm -f /usr/local/bin/canos-update /etc/pacman.d/hooks/canos-os-release.hook
echo "CanOS updates are on. Restart Canvas with: canvas restart"
