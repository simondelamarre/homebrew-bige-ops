# frozen_string_literal: true

# Desktop app cask — install: brew install --cask bige-ops
# Binaries live on the PUBLIC releases repo (not the private source).
#
# After publishing vX.Y.Z, replace version + sha256 (see scripts/bump-homebrew-cask.sh).

cask "bige-ops" do
  version "0.2.0"
  sha256 "42c33494afd356acdfa95ef19936d1c1148cbabe60ed90c86786bc084668a7a9"

  url "https://github.com/simondelamarre/bige-ops-releases/releases/download/v#{version}/bige-ops-#{version}-macos-aarch64.dmg"
  name "bige-ops"
  desc "Understand, simulate, and deploy Outscale stacks"
  homepage "https://github.com/simondelamarre/bige-ops-releases"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "bige-ops.app"

  zap trash: [
    "~/Library/Application Support/bige-ops",
    "~/Library/Caches/com.bige.ops",
    "~/Library/Preferences/com.bige.ops.plist",
  ]
end
