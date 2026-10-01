# Homebrew cask for the native macOS game (rendered by packaging/render.sh).
#   brew install --cask jairofernandez/kubiverse/kubiverse
cask "kubiverse" do
  version "0.1.16"
  sha256 "e53d397173bbcc3d8f62895fcfed3bb5403623fb07045586d65c9a67e4660d3c"

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
