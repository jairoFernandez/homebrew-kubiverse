# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.18/kubiverse-bridge-darwin-arm64"
      sha256 "ca814a3d1971c6731d067a398f27d22c6036531776b7c0520ee5b34878f77478"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.18/kubiverse-bridge-darwin-amd64"
      sha256 "8cd736b260b73147a8fa3b77701cac0d076514402073b9e81e75e409e36ecc32"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.18/kubiverse-bridge-linux-arm64"
      sha256 "9643600d5a398b4691a21c922da2b9154dda212bb68d2244d5480d8062b3769c"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.18/kubiverse-bridge-linux-amd64"
      sha256 "5f9accff98ff2a9d81dba936a8b0be33dc113c54c87d716f7a2da5281c065154"
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
