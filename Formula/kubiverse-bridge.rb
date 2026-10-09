# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.26"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.26/kubiverse-bridge-darwin-arm64"
      sha256 "eae0c9d95500ee410fc3af06bc3bd43b24876fb7acb63151cd3d9c08f1c89517"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.26/kubiverse-bridge-darwin-amd64"
      sha256 "2f0d9944687c5626c7d56becb40bdabe12e780ec9c946788a7412d5f5ea2f37c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.26/kubiverse-bridge-linux-arm64"
      sha256 "d0f7d539f77e5b856bb2c4cd959a32701f2b849a879c0c2f2a20d29b5a55b5df"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.26/kubiverse-bridge-linux-amd64"
      sha256 "358174b3a98b4abf1d2ecd30ee4864e94332a6c1b56bc5617f08063999e7a63a"
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
