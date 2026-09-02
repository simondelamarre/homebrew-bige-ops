# Homebrew packaging stubs for bige-ops
#
# Homebrew does NOT host your binaries. A public tap only points at HTTPS URLs
# (here: GitHub Releases on the public bige-ops-releases repo).
#
# Setup once:
#   1. Create public repo: https://github.com/simondelamarre/homebrew-bige-ops
#      (naming rule: homebrew-<tap> so users run `brew tap simondelamarre/bige-ops`)
#   2. Copy Casks/bige-ops.rb (and optionally Formula/bige-ops.rb) into that repo
#   3. After each desktop release, bump version + sha256 (script below)
#
# Users:
#   brew tap simondelamarre/bige-ops
#   brew install --cask bige-ops          # desktop app (macOS)
#   brew install bige-ops                # CLI only (when Formula is published)
#
# Update cask after a release:
#   ./scripts/bump-homebrew-cask.sh 0.1.0
