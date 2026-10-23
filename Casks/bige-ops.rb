# frozen_string_literal: true

# Desktop app cask — install: brew install --cask bige-ops
# Binaries live on the PUBLIC releases repo (not the private source).
#
# After publishing vX.Y.Z, replace version + sha256 (see scripts/bump-homebrew-cask.sh).

cask "bige-ops" do
  version "0.8.0"
  sha256 "61e255ab6592c6bcf66d093be7fa36009e0ab5578a00504a29b27207c98ad9ae"

  url "https://github.com/simondelamarre/bige-ops-releases/releases/download/v#{version}/bige-ops-#{version}-macos-aarch64.dmg"
  name "bige-ops"
  desc "Understand, simulate, and deploy Outscale stacks"
  homepage "https://github.com/simondelamarre/bige-ops-releases"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "bige-ops.app"

  # Unsigned / non-notarized builds: macOS marks downloads as quarantined and
  # reports "is damaged". Clear quarantine + ensure a coherent ad-hoc signature.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/bige-ops.app"]
    run "/usr/bin/codesign", args: ["--force", "--deep", "--sign", "-", "{{appdir}}/bige-ops.app"]
  end

  zap trash: [
    "~/Library/Application Support/bige-ops",
    "~/Library/Caches/com.bige.ops",
    "~/Library/Preferences/com.bige.ops.plist",
  ]
end
