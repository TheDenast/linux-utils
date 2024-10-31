# This shell.nix optimizes python work on NixOS
#
# Put this file in repo root next to `requirements.txt`,
# and it will enable venv & use pip to install all necessary
# packages.

{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # Here you can set the name of the shell
  name = "python-dev";

  buildInputs = with pkgs; [
    python311
    python311Packages.pip
    python311Packages.virtualenv
  ];
  
  shellHook = ''
    # Create and activate virtual environment
    VENV=.venv
    if [ ! -d "$VENV" ]; then
      echo "Creating virtual environment..."
      virtualenv $VENV
    fi
    source $VENV/bin/activate
    
    # Install requirements if requirements.txt exists
    if [ -f requirements.txt ]; then
      echo "Installing requirements..."
      pip install -r requirements.txt
    fi

    # Here it opens fish (I prefer it)
    # feel free to remove it if you work in bash/zsh
    export SHELL=${pkgs.fish}/bin/fish
    exec fish
  '';
}
