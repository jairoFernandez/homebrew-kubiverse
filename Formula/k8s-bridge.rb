# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/k8s-bridge
class K8sBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.7/k8s-bridge-darwin-arm64"
      sha256 "9727170271b00cdb945f732223f3e4489ebe852c2629c8b664e5931c09b6cb37"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.7/k8s-bridge-darwin-amd64"
      sha256 "0f77a3123cbde59d0a575e6eff4a90788f31a745eed6b73e2858221e34e21acb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.7/k8s-bridge-linux-arm64"
      sha256 "9998b1727e13ef7d92b690c3d6f6f7f19cd6791ee6276a0b865c80c961b8ecff"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.7/k8s-bridge-linux-amd64"
      sha256 "6f2297e3b14c48c748a00ea8cf1447c0ce63ebb18a4fea1f32b6d2f212759454"
    end
  end

  depends_on "kubectl" => :recommended

  def install
    bin.install Dir["k8s-bridge-*"].first => "k8s-bridge"
  end

  def caveats
    <<~EOS
      Start it and open the game in your browser (it comes inside):
        k8s-bridge
        open http://127.0.0.1:8088
    EOS
  end

  test do
    assert_match "-addr", shell_output("#{bin}/k8s-bridge --help 2>&1", 2)
  end
end
