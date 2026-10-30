# frozen_string_literal: true

# Desktop app cask — install: brew install --cask bige-ops
# Binaries live on the PUBLIC releases repo (not the private source).
#
# After publishing vX.Y.Z, replace version + sha256 (see scripts/bump-homebrew-cask.sh).

cask "bige-ops" do
  version "0.9.0"
  sha256 "f59d40a6b83bfbf64b72633cbf5dfb5dbb0f41bcdeffe6748997cae9f6bd8d91"

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
