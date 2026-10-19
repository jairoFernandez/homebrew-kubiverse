# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.30"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.30/kubiverse-bridge-darwin-arm64"
      sha256 "3e9722c04582ea03678b255775c8bed5df362bf0af955202beeb6f9f6ad4f2be"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.30/kubiverse-bridge-darwin-amd64"
      sha256 "16e5a0a6d5cd590c9ac6f6a3750e380ee9a6198bfd4a2c80a64ee2350ded515c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.30/kubiverse-bridge-linux-arm64"
      sha256 "e669a0dfd514d4533c4e663fbcabc640bed8b048fb6e24aea6379bb4adcf2021"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.30/kubiverse-bridge-linux-amd64"
      sha256 "c7e8701bed13c74dfd53990da73d6d6c862a2cdc7f7cb1677e61324d36ed58d6"
    end
  end

  depends_on "kubectl" => :recommended

  def install
    bin.install Dir["kubiverse-bridge-*"].first => "kubiverse-bridge"
    # The old command keeps working for a while.
    bin.install_symlink "kubiverse-bridge" => "k8s-bridge"
  end

  def caveats
    <<~EOS
      The native app (brew install --cask jairofernandez/kubiverse/kubiverse)
      starts it by itself. To play in the browser instead (the game comes inside):
        kubiverse-bridge
        open http://127.0.0.1:8088
    EOS
  end

  test do
    assert_match "-addr", shell_output("#{bin}/kubiverse-bridge --help 2>&1", 2)
  end
end
