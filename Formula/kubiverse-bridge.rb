# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.17/kubiverse-bridge-darwin-arm64"
      sha256 "b1a5727edfb46ca14b18c03eb2d03409665473e6c3ed7abfb41e48d8a91f8fa4"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.17/kubiverse-bridge-darwin-amd64"
      sha256 "4792718a705e1727456b426da936a62989d7429207051fbde8e9cf5d6d5affe4"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.17/kubiverse-bridge-linux-arm64"
      sha256 "f2dad1d3e699637e0fb42051fcba78dc2ff1fbede3c06f1481e1cfa65c1d8e40"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.17/kubiverse-bridge-linux-amd64"
      sha256 "cce7809a1a7b8969ce5f9d4f2952db534940f2c07b94975be84e65a43567b6be"
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
