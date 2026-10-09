# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.29"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.29/kubiverse-bridge-darwin-arm64"
      sha256 "99d6f4f0abc76e5f3369f8625c334fcc0579ca148dc187a77cd9383b8186beb4"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.29/kubiverse-bridge-darwin-amd64"
      sha256 "822d30826a1326565e934457e9de158f13bf5033e79087401b729af26431cbcf"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.29/kubiverse-bridge-linux-arm64"
      sha256 "cb8bd094d10ad0c3410f205f6deeecd644d4e73d01ee64780c885306c5f60ec7"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.29/kubiverse-bridge-linux-amd64"
      sha256 "bab46123287e3c22bb1c9308e6d841c466340cdd8d5ec78fbbdc180de14f950f"
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
