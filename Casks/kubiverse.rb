# Homebrew cask for the native macOS game (rendered by packaging/render.sh).
#   brew install --cask jairofernandez/kubiverse/kubiverse
cask "kubiverse" do
  version "0.1.31"
  sha256 "57a87194f7ab44c6fa6b86cb8fe33160c3a3ae0660fc23e6e5f3aba995cc19a8"

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
    the app -> Open). The app starts kubiverse-bridge by itself (on
    127.0.0.1:28088, changeable on its start screen) and stops it on quit.
  EOS

  zap trash: "~/Library/Application Support/Godot/app_userdata/Kubiverse"
end
