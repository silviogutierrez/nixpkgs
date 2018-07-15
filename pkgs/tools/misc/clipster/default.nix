{fetchFromGitHub , stdenv, python3, gtk3, libwnck3,
 gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation  rec {
  name = "clipster-${version}";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "mrichar1";
    repo = "clipster";
    rev = "${version}";
    sha256 = "0v1412zdkps21i5bw1p7jdv5ydnbw9dcr02318qr5mvk8lwdmsgw";
  };

  pythonEnv = python3.withPackages(ps: with ps; [ pygobject3 ]);

  buildInputs =  [ pythonEnv gtk3 libwnck3 gobjectIntrospection wrapGAppsHook ];

  installPhase = ''
    sed -i 's/python/python3/g' clipster
    mkdir -p $out/bin/
    cp clipster $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "lightweight python clipboard manager";
    longDescription = ''
      Clipster was designed to try to add a good selection of useful features, while avoiding bad design decisions or becoming excessively large.
      Its feature list includes:
      - Event driven, rather than polling. More efficient, helps with power management.
      - Control over when it write to disk, for similar reasons.
      - Command-line options/config for everything.
      - No global keybindings - that's the job of a Window Manager
      - Sensible handling of unusual clipboard events. Some apps (Chrome, Emacs) trigger a clipboard 'update event' for every character you select, rather than just one event when you stop selecting.
      - Preserves the last item in clipboard after an application closes. (Many apps clear the clipboard on exit).
      - Minimal dependencies, no complicated build/install requirements.
      - utf-8 support
      - Proper handling of embedded newlines and control codes.
      - Smart matching of urls, emails, regexes. (extract_*)
      - Option to synchronise the SELECTION and CLIPBOARD clipboards. (sync_selections)
      - Option to track one or both clipboards. (active_selections)
      - Option to ignore clipboard updates form certain applications. (filter_classes)
      - Ability to delete items in clipboard history.
    '';
    license = licenses.agpl3;
    homepage = https://github.com/mrichar1/clipster;
    platforms = platforms.linux;
    maintainers = [ maintainers.magnetophon ];
  };
}
