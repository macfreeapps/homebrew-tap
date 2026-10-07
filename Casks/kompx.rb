cask "kompx" do
  version "5.1.2"
  sha256 "9949c2696967f054e4a3ff9b34a23441cb8e34c7f0c1424c864d7457c7b2a48d"

  url "https://github.com/macfreeapps/kompx/releases/download/v#{version}/komPX-#{version}-universal.dmg"
  name "komPX"
  desc "Local image and video compressor"
  homepage "https://github.com/macfreeapps/kompx"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "komPX.app"

  uninstall quit: "com.kompx.komPX"

  zap trash: [
    "~/Library/Preferences/com.kompx.komPX.plist",
    "~/Library/Saved Application State/com.kompx.komPX.savedState",
  ]

  caveats <<~EOS
    komPX is ad-hoc signed and is not notarized by Apple.
    On first launch, macOS may require approval in System Settings → Privacy & Security → Open Anyway.
  EOS
end
