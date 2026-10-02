# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.20/kubiverse-bridge-darwin-arm64"
      sha256 "d15174653ba90d803ed1211a522556ab322a0e43cd4db8cd955a3241a78a7adf"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.20/kubiverse-bridge-darwin-amd64"
      sha256 "bfcbc7b5687989741ac276e8e5ca9ad7abe2c61981768fb79ac58f4af007e286"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.20/kubiverse-bridge-linux-arm64"
      sha256 "0fb6bcc436c9f63515646918b8990a2a1d6bd204efbfd51bb59c20b11be1c7a3"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.20/kubiverse-bridge-linux-amd64"
      sha256 "8551c5fea6c1671cb4b8a9f7968b9fffb61ffd9f73ea84cc7e4864af50470e92"
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
