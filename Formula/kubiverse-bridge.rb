# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.28"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.28/kubiverse-bridge-darwin-arm64"
      sha256 "69796221b7964e64f3f5ba39d19e34a1f45a054e660cd6fcf2226c36940bdcc1"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.28/kubiverse-bridge-darwin-amd64"
      sha256 "89c4316e69816ede51f1c46bc2b1ca96458cca55665ba00ea925a613a5cef486"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.28/kubiverse-bridge-linux-arm64"
      sha256 "75baf935475db415c9f0d48005b7e91703619e85053523b53a81a9147706f623"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.28/kubiverse-bridge-linux-amd64"
      sha256 "464297500bf1c25bef776a4656cbbc663ead9d8388238d4475b3c6baa9952b08"
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
