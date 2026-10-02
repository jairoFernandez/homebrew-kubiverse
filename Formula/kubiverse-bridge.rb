# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.19/kubiverse-bridge-darwin-arm64"
      sha256 "0fdf145b086ce07cd3695d496d32db7940104048848b804306110700b8a4337c"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.19/kubiverse-bridge-darwin-amd64"
      sha256 "0e0b38d318d322dc7ff6de72cbc8f7c1d99765e03d1b64d316cbada54fdb9a84"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.19/kubiverse-bridge-linux-arm64"
      sha256 "b98eba57c7bf7354031d0855d7917ad71c6311496c2ad885dca6b321be709943"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.19/kubiverse-bridge-linux-amd64"
      sha256 "fc19ccc376296b982d4ac2d25e616f9bb2a9e2fdc5f30f47c09471b17b3791e6"
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
