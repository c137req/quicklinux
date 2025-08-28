# disabling ipv6 2 ways

## editing GRUB config

this will disable ipv6 at kernel level - if you plan on using ipv6 with anything in the future, do the sysctl one as it keeps the `net.ipv6.conf` module loaded

1. making sure you're actually using GRUB bootloader (skip to other way to disable ipv6 if you're not using GRUB)
   
   ```bash
   [req@c137 ~]$ find /etc/default -name "grub"
   /etc/default/grub
   ```

2. use nano, vim, emacs, neovim, whatever to edit `/etc/default/grub` cmdline linux default line to disable ipv6 via quiet splash
   
   ```bash
   [req@c137 ~]$ sudo nano /etc/default/grub
   ```
   
   ```bash
   GRUB_DEFAULT=0
   GRUB_TIMEOUT=5
   GRUB_DISTRIBUTOR="Arch"
   GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet intel_iommu=on"
   GRUB_CMDLINE_LINUX="zswap.enabled=0 rootfstype=ext4"
   ```
   
   add `splash ipv6.disable=1` to the end of `GRUB_CMDLINE_LINUX_DEFAULT` like this:
   
   ```bash
   GRUB_DEFAULT=0
   GRUB_TIMEOUT=5
   GRUB_DISTRIBUTOR="Arch"
   GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet intel_iommu=on splash ipv6.disable=1"
   GRUB_CMDLINE_LINUX="zswap.enabled=0 rootfstype=ext4"
   ```

3. redo `sudo grub-mkconfig -o /boot/grub/grub.cfg` to generate a new config which disables ipv6

4. `reboot` and then check for ipv6 addresses with `ip a`, then double check with `/proc/cmdline` output

## via sysctl

1. make `/etc/sysctl.d/99-disable-ipv6.conf` (don't change name or sysctl will hit you)

2. add
   
   ```bash
   net.ipv6.conf.all.disable_ipv6 = 1
   net.ipv6.conf.default.disable_ipv6 = 1
   net.ipv6.conf.lo.disable_ipv6 = 1
   ```
   
   to `/etc/sysctl.d/99-disable-ipv6.conf`

3. execute `sudo sysctl -p /etc/sysctl.d/99-disable-ipv6.conf`

4. check status with `sysctl net.ipv6.conf.all.disable_ipv6`
   
   ```bash
   [req@c137 ~]$ sysctl net.ipv6.conf.all.disable_ipv6
   net.ipv6.conf.all.disable_ipv6 = 1
   ```


