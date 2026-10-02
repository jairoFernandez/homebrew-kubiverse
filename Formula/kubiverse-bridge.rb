# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.23"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.23/kubiverse-bridge-darwin-arm64"
      sha256 "c2a1a7e399a5f3414bdc357607340dfeb2a84a29293de8531e90681d01d2eaab"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.23/kubiverse-bridge-darwin-amd64"
      sha256 "4a81e60fb900a5ec4d6e4258ecf94853fc7a3b03ad7b988fb3f824a8390b1adf"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.23/kubiverse-bridge-linux-arm64"
      sha256 "021d806d7bd91e888c977f3c94f346a135a5927d8907a5c8b6ffe49cfb412e6c"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.23/kubiverse-bridge-linux-amd64"
      sha256 "2b32b6d7fecdc0e8fdad38f88da5b4eb638c91347edb5c3954bf02ed92a31373"
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
