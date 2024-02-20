echo "pt_BR ISO-8859-1" >> /etc/locale.gen && \
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen && \
locale-gen && \
echo "LANG="pt_BR.UTF-8" \
LC_COLLATE="C" " >> /etc/env.d/02locale && \
env-update && source /etc/profile && \
emerge-webrsync && \
clear && \
echo "Digite sua senha root" && \
passwd && \
clear && \
eselect profile list && \
echo "Digite o número do profile desejado"
read PROFILE && \
eselect profile set $PROFILE && \
emerge cpuid2cpuflags && \
clear && \

#Make.conf mínimo, altere conforme suas configurações
echo 'CFLAGS="-march=native -mtune=native -O2 -pipe"
#CFLAGS="-march=native -mtune=native -O3 -pipe"
CXXFLAGS="${CFLAGS}"
FFLAGS="${CFLAGS}"
FCFLAGS="${FFLAGS}"
CHOST="x86_64-pc-linux-gnu"
FEATURES="parallel-fetch noman noinfo nodoc"
ACCEPT_KEYWORDS="amd64"
GRUB_PLATFORMS="efi-32 efi-64 pc"

MAKEOPTS="-s -j4"
EMERGE_DEFAULT_OPTS="--jobs=4 --load-average=4 --autounmask-write=y --with-bdeps=y --keep-going=y"
ACCEPT_LICENSE="**"
ACCEPT_PROPERTIES="-interactive"
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"
PORTAGE_NICENESS=10
AUTOCLEAN="yes"

LINGUAS="pt_BR.UTF-8 pt_BR.ISO8859-1 pt_BR.iso8859-1 pt_BR pt-BR"
L10N="pt_BR"

INPUT_DEVICES="libinput"

VIDEO_CARDS="intel i965 iris"
#VIDEO_CARDS="nvidia"
#VIDEO_CARDS="r600 amdgpu"

USE="X wayland xwayland bluetooth -consolekit -systemd pulseaudio alsa pgo lto graphite drm imlib eudev udisks mtp nls icu elogind opencl opengl dri dri3 v4l libcaca vpx srt theora ogg vorbis vulkan x264 x265 matroska mkv aac lame mp3 webp tiff jpeg png raw gstreamer openssl ffmpeg googledrive pdfimport staging mono gecko gles2"

GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/ \
                ftp://gentoo.c3sl.ufpr.br/gentoo/ \
                http://distfiles.gentoo.org/ \
                rsync://gentoo.c3sl.ufpr.br/gentoo/" ' > /etc/portage/make.conf && \
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags && \
nano /etc/portage/make.conf && \
cd /etc/portage/package.use/ && sed -i 's/CPU_FLAGS_X86:/CPU_FLAGS_X86=/g' 00cpu-flags && \
nano /etc/portage/package.use/00cpu-flags && \
blkid && \
echo "Digite o nome do HD que irá armazenar o sistema (ex. sda)" && \
read HARDDISK
echo "Se seu sistema for UEFI, defina a partição para a criação do /boot/efi" && \
read EFIPART && \
mkdir -p /boot/efi && \
mount -t vfat /dev/$EFIPART /boot/efi && \
echo "Digite a partição root" && \
read ROOTPART && \
echo "/dev/$ROOTPART / ext4 noatime 0 1
/dev/$EFIPART /boot/efi vfat defaults,noatime 0 2
#/dev/sdb3 /home ext4 defaults 0 0
#proc /proc proc defaults 0 0
#tmpfs /dev/shm tmpfs defaults 0 0
#tmpfs /var/tmp/portage tmpfs rw,nodev,nosuid,size=8G
#devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620 0 0
" > /etc/fstab && \
nano /etc/fstab && \
echo "Digite o nome da máquina na rede" && \
read HOSTNAME && \
echo "hostname=$HOSTNAME" > /etc/conf.d/hostname && \
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE 
app-arch/unrar unRAR" | tee -a /etc/portage/package.license && \
emerge -1 sys-kernel/gentoo-kernel-bin && emerge app-admin/gentoo-perl-helpers && \
etc-update --automode -5 && \
emerge -1 sys-kernel/gentoo-kernel-bin && emerge app-admin/gentoo-perl-helpers && \
mkdir -p /etc/modules-load.d/ && \
echo "tun" >> /etc/modules-load.d/networking.conf && \
#Teclado e fuso horário
echo'# Use keymap to specify the default console keymap.  There is a complete tree
# of keymaps in /usr/share/keymaps to choose from.
keymap="br-abnt2"

# Should we first load the 'windowkeys' console keymap?  Most x86 users will
# say "yes" here.  Note that non-x86 users should leave it as "no".
# Loading this keymap will enable VT switching (like ALT+Left/Right)
# using the special windows keys on the linux console.
windowkeys="YES"

# The maps to load for extended keyboards.  Most users will leave this as is.
extended_keymaps=""
#extended_keymaps="backspace keypad euro2"

# Tell dumpkeys(1) to interpret character action codes to be
# from the specified character set.
# This only matters if you set unicode="yes" in /etc/rc.conf.
# For a list of valid sets, run `dumpkeys --help`
dumpkeys_charset=""

# Some fonts map AltGr-E to the currency symbol instead of the Euro.
# To fix this, set to "yes"
fix_euro="NO"' >> /etc/conf.d/keymaps && \
cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
echo "dev-lang/mono minimal
media-libs/libsndfile minimal
media-libs/freetype harfbuzz
sys-boot/grub mount
dev-util/ostree curl
dev-lang/python -bluetooth
media-libs/imlib2
media-libs/mesa -opencl -vaapi
net-dns/dnsmasq dbus
net-misc/networkmanager -gtk-doc connection-sharing bluetooth iptables
www-client/w3m X fbcon gdk-pixbuf gpm unicode -imlib
" >> /etc/portage/package.use/packagesset && \
env-update && source /etc/profile && etc-update --automode -5 && \
emerge --update --newuse --deep --with-bdeps=y @world && \
etc-update --automode -5 && \
emerge linux-firmware sof-firmware dhcpcd dev-vcs/git syslog-ng cronie mlocate networkmanager mesa dvtm irssi w3m nload gentoolkit wpa_supplicant iwd superadduser grub os-prober xorg-server xinit mpv yt-dlp htop unrar zip unzip p7zip podman sys-apps/flatpak sys-auth/seatd gui-libs/xdg-desktop-portal-wlr feh picom scrot mpd ncmpcpp bluez minidlna rtorrent newsboat cowsay fortune-mod cmatrix media-libs/libva-intel-driver && \
etc-update --automode -5 && \
emerge linux-firmware sof-firmware dhcpcd dev-vcs/git syslog-ng cronie mlocate networkmanager mesa dvtm irssi w3m nload gentoolkit wpa_supplicant iwd superadduser grub os-prober xorg-server xinit mpv yt-dlp htop unrar zip unzip p7zip podman sys-apps/flatpak sys-auth/seatd gui-libs/xdg-desktop-portal-wlr feh picom scrot mpd ncmpcpp bluez minidlna rtorrent newsboat cowsay fortune-mod cmatrix media-libs/libva-intel-driver && \
rc-update add NetworkManager default && rc-update add syslog-ng default && rc-update add cronie default && rc-update add seatd default && \
etc-update --automode -5 && \
emerge @preserved-rebuild && \
eclean distfiles && \
eclean packages && \
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Gentoo Linux [GRUB]" --recheck /dev/$HARDDISK && \
#grub-install --target=i386-efi --efi-directory=/boot/efi --bootloader-id="Gentoo Linux [GRUB]" --recheck /dev/$HARDDISK && \
#grub-install --target=i386-pc --no-floppy /dev/$HARDDISK && \
grub-mkconfig -o /boot/grub/grub.cfg && \
echo "Finalizado o script! Reinicie quando for conveniente!
Com essa instalação você já tem conexão com internet (networkmanager),
 irssi (cliente mirc), w3m (navegador cli) , mpv (player multimídia), suporte a flatpak, podman, xorg e wayland"
