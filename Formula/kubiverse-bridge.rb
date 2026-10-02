# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.22"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.22/kubiverse-bridge-darwin-arm64"
      sha256 "7bde4ae41f209b2a98b81bb405be3b3bf63ffdfae087760030fe5ab1b07aeb39"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.22/kubiverse-bridge-darwin-amd64"
      sha256 "2b06e8ead3c954d28fffca840de7f6c899756f2cec5e95f7413b08ab86c22500"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.22/kubiverse-bridge-linux-arm64"
      sha256 "c09205ce108a36e6407debaa81bda411e4c84d50b0a2dd99a70307515f6b3aab"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.22/kubiverse-bridge-linux-amd64"
      sha256 "12ad4486e4e08955715830b84b8dfe21439b4bcf88a4bcd88361114d93ee27a6"
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
