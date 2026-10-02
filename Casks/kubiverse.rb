# Homebrew cask for the native macOS game (rendered by packaging/render.sh).
#   brew install --cask jairofernandez/kubiverse/kubiverse
cask "kubiverse" do
  version "0.1.20"
  sha256 "d1828b4cfaf38cc576289728303a8fd220269143693ec61f31091f4df3308429"

  url "https://github.com/jairoFernandez/kubiverse/releases/download/v#{version}/kubiverse-macos.zip"
  name "Kubiverse"
  desc "Your Kubernetes cluster as a voxel world"
  homepage "https://github.com/jairoFernandez/kubiverse"

  depends_on formula: "jairofernandez/kubiverse/kubiverse-bridge"

  app "Kubiverse.app"

  caveats <<~EOS
    Kubiverse isn't notarized by Apple yet, so macOS blocks it the first
    time ("can't be opened" / "is damaged"). Allow it once with:

      xattr -dr com.apple.quarantine /Applications/Kubiverse.app

    (that removes the "downloaded from the Internet" flag; or right-click
    the app -> Open). Then start the bridge and open the app:

      kubiverse-bridge
  EOS

  zap trash: "~/Library/Application Support/Godot/app_userdata/Kubiverse"
end
