# frozen_string_literal: true

# SPDX-License-Identifier: MIT
cask "ultraconvert" do
  version "1.8.3"
  sha256 "6cd25bd5a51d0192300cf849abcea71949002b82068456b16d51696339d8ffda"

  url "https://github.com/samuel-zhang01/UltraConvert/releases/download/v#{version}/UltraConvert-#{version}-update-macos-universal.zip"
  name "UltraConvert"
  desc "Local file converter with Finder shortcuts and folder rules"
  homepage "https://github.com/samuel-zhang01/UltraConvert"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on cask: "calibre"
  depends_on formula: "samuel-zhang01/ultraconvert/ultraconvert-runtime"
  depends_on macos: :ventura

  app "UltraConvert.app"

  uninstall quit:   "local.ultraconvert",
            script: {
              executable: "#{HOMEBREW_PREFIX}/bin/ultraconvert-remove-finder-actions",
              args:       ["--app", "#{appdir}/UltraConvert.app"],
              sudo:       false,
            }

  caveats <<~EOS
    Open UltraConvert once to register Finder actions, then enable them in macOS Settings.
    Settings and folder rules are retained by normal uninstall and upgrades.
    App updates use Check for Updates; use brew upgrade for the conversion runtime.
  EOS
end
