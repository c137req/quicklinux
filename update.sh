# auto update arch using a cronjob
# --noconfirm flag so you don't have to touch your computer while it happens

(crontab -l 2>/dev/null; echo "30 16 * * 0 /usr/bin/pacman -Syu --noconfirm") | crontab -
