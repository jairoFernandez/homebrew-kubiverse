# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.32/kubiverse-bridge-darwin-arm64"
      sha256 "1a7e7451b36b0a15158139bf5c7c333ced57608283dff2df44dcee142668d8f9"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.32/kubiverse-bridge-darwin-amd64"
      sha256 "d149088dbdaf8b5d4ce72243b509ec62bb976d4f9d35378fc9bab91731d81638"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.32/kubiverse-bridge-linux-arm64"
      sha256 "27c5b0d1a1049540a0cdb4f8aec012311c9cd419c7bd34c6f0ff659fb0076883"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.32/kubiverse-bridge-linux-amd64"
      sha256 "ac29c92e2cbf91f6d37adf058c51daa04a2a8ca6d6970260936fdfa0e285ccb8"
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
