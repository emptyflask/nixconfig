let
  backup = path: {
    paths = path;
    repo = "/media/backup/${baseNameOf path}";
    doInit = false; # flip for new backup jobs
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/backup-password";
    };
    compression = "auto,lzma";
    startAt = "weekly";
  };
in
  {
    jobs = {

      boot = backup "/boot";

      etc = backup "/etc";

      jon = backup "/home/jon" // {
        exclude = [
          "/home/jon/tmp"
          "/home/jon/Downloads"
          "'**/.cache'"
          "'**/node_modules'"
        ];
      };

      root = backup "/root" // {
        exclude = ["/root/tmp" "'**/.cache'"];
      };

      repository = backup "/media/repository" // {
        encryption = { mode = "none"; };
        exclude = [
          "'/media/repository/.*'"
          "/media/repository/movies"
        ];
      };

    };
  }
