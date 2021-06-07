{pkgs, ...}:

{
  imports = [ <home-manager/nixos> ];

  nix.trustedUsers = [ "root" "jon" ];

  environment.homeBinInPath = true;

  users = {
    users.root.initialHashedPassword = "";

    users.jon = {
      description = "Jon Roberts";
      initialPassword = "changeme";
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "audio"
        "dialout"
        "docker"
        "libvirtd"
        "mlocate"
        "networkmanager"
        "postgres"
        "sabnzbd"
        "vboxusers"
        "wheel"
      ];
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAt18V4yTovuS+lujydJH1XnQBhs+UXDQTQAvM5Dmypo4A+O/LET07MbEicW+QgXF+gvoyUDvyP44FQdH0GwVrO78F7t6Aqy3XTTRk7+myITjULKgv8t6Dayk0iLHeUZ1y1VgeV5v5jgHTCkNTsN6fi14IH8wgiexsZfOBaM7XdH0= velazquez"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPxtZvN1N9qftL+TtsKpWlFgiWffNq44RRc6R616V94hVm+m4lPiFjg7r+uKqjDmXpqdmT2DFxafG2rAT8WmKBdijqhL4EjuFGDiPSWlwOLU6o+yD0g6MJ5MpQX+CIthR8z9KzMkyrv3RQ8rfmvjRl+Qbhj+6dBAnaPlGixUrzrmH89k+EBKvfRHTjjBM/ZdxQ834GluWOm/NdoRA6dcoMVjKG9NagxRtcy/0MQcIF1aO3BsmtXoTtx6DxVyuEjLGoqeFErBJYWcHekb0YxkV6FyFbbNoiIWNAS6siy0fXavkvabBxF5yKEebpDCcMpko2f6KxgP2Gr6u9Q4cNHOHd jon@sargent.local"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjyj3WdBZOAdTU8dM6cMX6BedQc2Xt/vSzEZt1PjB/+93cC0KAdZlf/sQc6pnfe5O5iebEhO6ZLiaHHl7jtXa5GAs64sNTEGHrR3GuDbIkm8/L2pkj5EoFB8/vPZxmi7IdfbMMxyUnSsO2jPl5HBXuH8TMTxWx6ygTgqnMmvJJwMI4qHliJ/wQbFWD+bB8bvgY0VKS044+CRaiWLsjAhaQjW5curzTtTxPdc1Ug+4PH9A4d2vwuqqBOtmDbrKZoeWYHOZYMHSIZrtew6AbXohv1472V13yt/tUi+qhNYvEyAj51zfHH45AbfCxRRwd6rrX9PY8dC0G3Zc2aijXWYb3 pi@raspberrypi"
      ];
    };

  };

  home-manager = {
    useUserPackages = true;
    users.jon = import ./jon/home-manager/home-nixos.nix;
  };
}
