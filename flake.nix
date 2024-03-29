{
  description = ''Game framework, modular and extensible'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."c4-master".dir   = "master";
  inputs."c4-master".owner = "nim-nix-pkgs";
  inputs."c4-master".ref   = "master";
  inputs."c4-master".repo  = "c4";
  inputs."c4-master".type  = "github";
  inputs."c4-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."c4-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}