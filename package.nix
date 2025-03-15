{
  lib,
  lv2,
  libXi,
  unzip,
  libGLU,
  libX11,
  stdenv,
  alsa-lib,
  fetchurl,
  freetype,
  libjack2,
  fontconfig,
  libXinerama,
  libpulseaudio,
  webkitgtk_4_0,
  autoPatchelfHook,
}: let
  version = "0.6.0";
in
  stdenv.mkDerivation (_finalAttrs: {
    pname = "zlequalizer";
    inherit version;

    src = fetchurl {
      url = "https://github.com/ZL-Audio/ZLEqualizer/releases/download/${version}/ZL.Equalizer-${version}-Linux.zip";
      hash = "sha256-mjlHqB4T/3jpYnJvIbKLV6EftKp1PcEJpgoplyuZTJI=";
    };

    nativeBuildInputs = [
      unzip
      autoPatchelfHook
    ];

    propagatedBuildInputs = [
      lv2
      libXi
      libGLU
      libX11
      alsa-lib
      freetype
      libjack2
      fontconfig
      libXinerama
      libpulseaudio
      webkitgtk_4_0
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/vst3
      mkdir -p $out/lib/lv2

      cp -r VST3/* $out/lib/vst3
      cp -r LV2/* $out/lib/lv2

      install -D Standalone/"ZL Equalizer" $out/bin/zlequalizer

      runHook postInstall
    '';

    meta = {
      description = "ZL Equalizer is a VST3, LV2 and standalone equalizer plugin.";
      homepage = "https://github.com/ZL-Audio/ZLEqualizer";
      license = lib.licenses.agpl3Only;
      platforms = ["x86_64-linux"];
      mainProgram = "zlequalizer";
    };
  })
