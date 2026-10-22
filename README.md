# nix-orchard

Nix and Home Manager configurations for our Macs.

| Machine | Hardware | macOS account | Home module |
| --- | --- | --- | --- |
| `honeycrisp` | Mac Mini M4 | `breakds` | `home-breakds` |
| `sweetango` | MacBook Air M5 | `shanqi` | `home-cassandra` |

## Configuration

- `modules/common.nix`: flakes, unfree packages, fonts, and shared account wiring.
- `modules/part.nix`: shared Homebrew policy and personal home modules.
- `machines/<name>/default.nix`: hostname, platform, `system.primaryUser`, apps, and desktop preferences.
- `modules/home-<person>/`: personal home settings.

Each machine sets `system.primaryUser` to an existing macOS account. Home Manager
and Homebrew use that account. `honeycrisp` starts with zsh, Starship, and Ghostty,
installed and configured through Home Manager. Rosetta Homebrew is enabled only
on `sweetango`.

## First installation on honeycrisp

Log in as `breakds`, with home directory `/Users/breakds` and administrator access.

1. Install the Apple Command Line Tools and finish the installation dialog:

   ```sh
   xcode-select --install
   ```

2. Install [multi-user Nix](https://nix.dev/manual/nix/2.34/installation/installing-binary.html#multi-user-installation):

   ```sh
   curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon
   ```

   Open a new Terminal window, then check `nix --version`.

3. Clone this repository over HTTPS:

   ```sh
   git clone https://github.com/breakds/nix-orchard.git
   cd nix-orchard
   ```

4. Build using `darwin-rebuild` from this repository's locked inputs:

   ```sh
   nix --extra-experimental-features 'nix-command flakes' run \
     .#darwinConfigurations.honeycrisp.config.system.build.darwin-rebuild \
     -- build --flake .#honeycrisp
   ```

5. Activate the configuration:

   ```sh
   sudo nix --extra-experimental-features 'nix-command flakes' run \
     .#darwinConfigurations.honeycrisp.config.system.build.darwin-rebuild \
     -- switch --flake .#honeycrisp
   ```

   Activation installs Homebrew and applies the `home-breakds` configuration.
   Open a new Terminal window afterward.

## Subsequent changes

From the repository, build and activate with:

```sh
darwin-rebuild build --flake .#honeycrisp
sudo darwin-rebuild switch --flake .#honeycrisp
```

Use `.#sweetango` on `sweetango`. To update the pinned inputs, run `nix flake update`
before rebuilding. Keep each machine's `system.stateVersion` and each home module's
`home.stateVersion` when updating inputs.

Homebrew upgrades declared packages during activation and removes undeclared ones
with `"zap"` cleanup, including associated files for casks. Homebrew and its taps
are updated through the flake inputs.

## References

1. [Dreams of Autonomy's introduction to nix-darwin video](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
2. [nix-homebrew](https://github.com/zhaofengli/nix-homebrew)
