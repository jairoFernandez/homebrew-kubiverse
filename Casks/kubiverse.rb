# Homebrew cask for the native macOS game (rendered by packaging/render.sh).
#   brew install --cask jairofernandez/kubiverse/kubiverse
cask "kubiverse" do
  version "0.1.7"
  sha256 "94d8dfd3f6dcabb48d2bc1920662d33b2ffb6803baf51c02fb14c4dca7260d26"

  url "https://github.com/jairoFernandez/kubiverse/releases/download/v#{version}/kubiverse-macos.zip"
  name "Kubiverse"
  desc "Your Kubernetes cluster as a voxel world"
  homepage "https://github.com/jairoFernandez/kubiverse"

  depends_on formula: "jairofernandez/kubiverse/k8s-bridge"

  app "Kubiverse.app"

  zap trash: "~/Library/Application Support/Godot/app_userdata/Kubiverse"
end
