#include <tunables/global>

# forbid mount of devtmpfs inside container

/usr/bin/lxc-start flags=(attach_disconnected) {
  network,
  capability,
  file,
  umount,

  mount -> /usr/lib/lxc/rootfs/{**,},

  pivot_root /usr/lib/lxc/rootfs/,

  mount fstype=devpts -> /dev/pts/,

  change_profile -> lxc-container,
}

profile lxc-container flags=(attach_disconnected, mediate_deleted) {
  network,
  capability,
  file,
  umount,

  deny mount options=(ro, remount) -> /,

  # Allow tmpfs mounts everywhere.
  mount fstype=tmpfs,

  # Allow mqueue mounts everywhere (who uses this?).
  mount fstype=mqueue,

  # Allow fuse mounts everywhere.
  mount fstype=fuse.*,

  deny mount fstype=devtmpfs,

  mount fstype=cgroup -> /sys/fs/cgroup/**,
  mount fstype=debugfs -> /sys/kernel/debug/,
  mount fstype=configfs -> /sys/kernel/config/,
  mount fstype=fusectl -> /sys/fs/fuse/connections/,
  mount fstype=hugetlbfs -> /dev/hugepages/,
  mount fstype=binfmt_misc -> /proc/sys/fs/binfmt_misc/,

  deny /proc/sys/fs/** wklx,

  deny /proc/sysrq-trigger rwklx,
  deny /proc/mem rwklx,
  deny /proc/kmem rwklx,
  deny /proc/sys/kernel/** wklx,

  deny /sys/[^f]*/** wklx,
  deny /sys/f[^s]*/** wklx,
  deny /sys/fs/[^c]*/** wklx,
  deny /sys/fs/c[^g]*/** wklx,
  deny /sys/fs/cg[^r]*/** wklx,
}
