# frozen_string_literal: true

# Desktop app cask — install: brew install --cask bige-ops
# Binaries live on the PUBLIC releases repo (not the private source).
#
# After publishing vX.Y.Z, replace version + sha256 (see scripts/bump-homebrew-cask.sh).

cask "bige-ops" do
  version "0.2.1"
  sha256 "4ca67571271014fbf6203cd632c2cb84707a04676d8b75f97671513656860ad7"

  url "https://github.com/simondelamarre/bige-ops-releases/releases/download/v#{version}/bige-ops-#{version}-macos-aarch64.dmg"
  name "bige-ops"
  desc "Understand, simulate, and deploy Outscale stacks"
  homepage "https://github.com/simondelamarre/bige-ops-releases"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "bige-ops.app"

  # Unsigned / non-notarized builds: macOS marks downloads as quarantined and
  # reports "is damaged". Clear quarantine + ensure a coherent ad-hoc signature.
  postflight do
    app_path = "#{appdir}/bige-ops.app"
    system_command "/usr/bin/xattr", args: ["-cr", app_path]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", app_path]
  end

  zap trash: [
    "~/Library/Application Support/bige-ops",
    "~/Library/Caches/com.bige.ops",
    "~/Library/Preferences/com.bige.ops.plist",
  ]
end
