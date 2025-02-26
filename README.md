# 🖼️ Assets Repository

A collection of high-quality assets for personal use, including wallpapers, avatars, lockscreen images, and icons. This repository is designed to be used with Nix and Home Manager for seamless integration into your system.

---

## 📂 Folder Structure

The repository is organized into the following folders:

- **`wallpapers/`**: A collection of stunning wallpapers for your desktop.
- **`avatars/`**: Profile pictures and avatars for various platforms.
- **`lockscreen/`**: Images optimized for lockscreen backgrounds.
- **`icons/`**: Custom icons for applications and system themes.

---

## 🚀 Usage

### Prerequisites
- [Nix](https://nixos.org/) installed on your system.
- [Home Manager](https://github.com/nix-community/home-manager) set up for user environment management.

### Adding the Assets Flake to Your Configuration

1. **Add the `assets` flake to your inputs**:
   ```nix
   inputs = {
     assets = {
       url = "github:Rouzihiro/assets";
       inputs.nixpkgs.follows = "nixpkgs";
     };
   };
```

2. ** Link the assets in your Home Manager configuration **:

```nix
home.file = {
  "Pictures/wallpapers" = {
    source = "${inputs.assets.packages.x86_64-linux.assets}/wallpapers";
    recursive = true;
  };
  "Pictures/avatars" = {
    source = "${inputs.assets.packages.x86_64-linux.assets}/avatars";
    recursive = true;
  };
  "Pictures/lockscreen" = {
    source = "${inputs.assets.packages.x86_64-linux.assets}/lockscreen";
    recursive = true;
  };
  "Pictures/icons" = {
    source = "${inputs.assets.packages.x86_64-linux.assets}/icons";
    recursive = true;
  };
};
```

Updating the Flake
If you add or remove folders, update the installPhase in the flake.nix file to reflect the changes.

📜 License
This repository is licensed under the MIT License. Feel free to use, modify, and distribute the assets as needed.

🌟 Show Your Support
If you find this repository useful, please consider giving it a ⭐️ on GitHub!

📬 Contact
For questions or suggestions, feel free to open an issue or reach out to Your Name.

🛡️ Badges
License: MIT
NixOS
Home Manager
