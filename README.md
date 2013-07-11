arch-apparmor
=============

AppArmor Arch Linux packages that are works

This packages provides:

* linux-apparmor enabled kernel (without modules, should be installed along
  with system kernel).

  **Note:** this version comes without modules, so you need to install ordinary
  kernel to get it work. It is done to reduce kernel build time and to avoid
  bricking system if linux-apparmor kernel will not boot.
* lxc with apparmor support enabled.
  lxc package contains apparmor profile for creating secure lxc-containers:
  see /usr/share/lxc/apparmor/lxc-containers.profile
