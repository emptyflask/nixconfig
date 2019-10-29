{pkgs, ...}:

{
  users = {
    users.root.initialHashedPassword = "";

    users.jon = {
      description = "Jon Roberts";
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "audio"
        "networkmanager"
        "postgres"
        "sabnzbd"
        "wheel"
      ];
      shell = pkgs.zsh;
    };

    extraGroups.vboxusers.members = ["jon"];
  };
}
