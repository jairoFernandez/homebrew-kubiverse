# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.16/kubiverse-bridge-darwin-arm64"
      sha256 "9b62468a85fc2486f1803424dfdfdd7ea87e8cd26239b07d111fdf2266d32fc2"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.16/kubiverse-bridge-darwin-amd64"
      sha256 "b95f9dab8c2bf0ce0ca59d4a869b0a3b2874a31fd429ab1fb9813e41b81a599f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.16/kubiverse-bridge-linux-arm64"
      sha256 "b8fbea5c5121869ad763639dca1784538ee1b78856d2a60eab91b149ab351207"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.16/kubiverse-bridge-linux-amd64"
      sha256 "6ae82f0b29ab587a2483117a6adee3a28e06431bcfd06ec97928319f8909f1eb"
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
