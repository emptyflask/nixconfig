# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/22f15aa1-8b19-461b-bf4d-77c84af52416";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6fc9222a-632d-4dbd-918b-67d79056e3af";
      fsType = "ext4";
    };

  fileSystems."/media/work" =
    { device = "/dev/disk/by-uuid/0a11a6e6-d40f-44dc-9f7f-4ab9109e66b7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/16EB-79D4";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3e3a1f6e-6d70-43bf-9900-6f70a624b96a"; }
    ];

  nix.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
