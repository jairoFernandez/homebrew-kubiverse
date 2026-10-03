# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.24"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.24/kubiverse-bridge-darwin-arm64"
      sha256 "d1fceede65312f6e94d1f31bf7ac8489411f260d89df5ac067ea07f294c48f42"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.24/kubiverse-bridge-darwin-amd64"
      sha256 "22b0690b6037ea08346af736ba3c3ba1abc7513ba4955a5f624e6e4e0ccc23be"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.24/kubiverse-bridge-linux-arm64"
      sha256 "8df8d733456b547cef124e9f45aa805afe921746809cf93e2c10fbc76634a9ed"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.24/kubiverse-bridge-linux-amd64"
      sha256 "d3c8558428bc79c856b17c34dbd5fa03f53be8244e58a77369a6061b9255dca5"
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
