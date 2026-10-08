cask "cineframe" do
  version "1.0.0"
  sha256 "2172128f68171f368eab308bf2b9acc070f9f4c8c0a02b7476865959f5f894c7"

  url "https://github.com/macfreeapps/cineframe/releases/download/v#{version}/CineFrame-#{version}-universal.dmg"
  name "Cine Frame"
  desc "Create cinematic crops with balanced 16:9 letterboxing"
  homepage "https://github.com/macfreeapps/cineframe"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "CineFrame.app"

  uninstall quit: "app.cineframe.CineFrame"

  zap trash: [
    "~/Library/Preferences/app.cineframe.CineFrame.plist",
    "~/Library/Saved Application State/app.cineframe.CineFrame.savedState",
  ]

  caveats <<~EOS
    CineFrame is ad-hoc signed and is not notarized by Apple.
    On first launch, macOS may require approval in System Settings → Privacy & Security → Open Anyway.
  EOS
end
