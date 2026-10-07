cask "kompx" do
  version "5.1.3"
  sha256 "80bf5f6827b50ca48aed40355586fbc365bf5df30dc9ae868ea90e58a54b7014"

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
