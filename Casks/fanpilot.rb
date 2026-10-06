cask "fanpilot" do
  version "1.0.0"
  sha256 "152b34678cbc6644513ef30cc3a1aadcff13a8f51b523e0de38a37468e3f337c"

  url "https://github.com/macfreeapps/fanpilot/releases/download/v#{version}/FanPilot-#{version}-arm64.dmg"
  name "FanPilot"
  desc "Menu-bar temperature and fan control for Apple Silicon Macs"
  homepage "https://github.com/macfreeapps/fanpilot"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "FanPilot.app"

  postflight do
    # FanPilot is not notarized, so clear the download quarantine flag; otherwise macOS refuses to open it.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FanPilot.app"]
  end

  uninstall quit:       "com.fanpilot.app",
            launchctl:  "com.fanpilot.helper",
            delete:     [
              "/Library/LaunchDaemons/com.fanpilot.helper.plist",
              "/Library/PrivilegedHelperTools/com.fanpilot.helper",
            ]

  zap delete: "/Library/Application Support/FanPilot",
      trash:  [
        "~/Library/Preferences/com.fanpilot.app.plist",
        "~/Library/Saved Application State/com.fanpilot.app.savedState",
      ]

  caveats <<~EOS
    FanPilot is not notarized by Apple (the developer has no paid Developer ID), so this cask clears the
    download quarantine flag for you. Open FanPilot and choose "Turn On Fan Control"; macOS asks for your
    password once to install the helper that changes fan speeds.

    The build is signed with a development certificate that expires on 28 June 2027.
  EOS
end
