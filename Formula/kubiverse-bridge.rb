# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.21"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.21/kubiverse-bridge-darwin-arm64"
      sha256 "15b03b9e6e9aee8369f5ae6ca47e500e21432b64d6aa90c7a56eee902f606ed5"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.21/kubiverse-bridge-darwin-amd64"
      sha256 "9385d9d5d7d680484813671367e85f8aabac578a54b56de013b2a20abb2c10f3"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.21/kubiverse-bridge-linux-arm64"
      sha256 "a3d11d8769f2dd841f6cdda1f91c76eb86c71af35da193129d82dc8ec73b4c8f"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.21/kubiverse-bridge-linux-amd64"
      sha256 "92f661e8c028e61741887b039718e9b27c27a6add1a153aff96265b83552440e"
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
      Start it and open the game in your browser (it comes inside):
        kubiverse-bridge
        open http://127.0.0.1:8088
    EOS
  end

  test do
    assert_match "-addr", shell_output("#{bin}/kubiverse-bridge --help 2>&1", 2)
  end
end
