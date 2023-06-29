1. Rebuild base on hostname
sudo nixos-rebuild boot --flake .#d3nixpc
nix-collect-garbage -d
nix-store --gc
git add . && git commit -m "0.0.6" && git push origin v0.0.6