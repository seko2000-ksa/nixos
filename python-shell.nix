{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    pkgs.python314
    pkgs.python314Packages.pip
    (pkgs.python314Packages.pipx.overridePythonAttrs (old: { doCheck = false; }))
    pkgs.ffmpeg
    pkgs.ffmpeg.dev
    pkgs.uv
    pkgs.procps
  ];

  buildInputs = with pkgs; [
    SDL2
    SDL2_image
    SDL2_ttf
    SDL2_mixer
    SDL2.dev
    procps
    ffmpeg.dev
    gst_all_1.gstreamer
    pango.dev
  ];

  # Libraries required by your program at runtime
  nativeBuildInputs = with pkgs; [
    pkgconf
    pkg-config
    gcc
  ];

  shellHook = ''
    # Create venv if it doesn't exist
    if [ ! -d ".venv" ]; then
      python -m venv .venv
    fi

    # Activate it automatically
    source .venv/bin/activate
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [pkgs.ffmpeg]}:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH="${pkgs.SDL2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
    LD_LIBRARY_PATH=${pkgs.SDL2}/lib
    LD_LIBRARY_PATH=${pkgs.SDL2_image}/lib
    echo $LD_LIBRARY_PATH
    pkg-config --cflags --libs sdl2 SDL2_image
    # Optional: Automatically sync requirements
    # pip install -r requirements.txt
  '';
}
