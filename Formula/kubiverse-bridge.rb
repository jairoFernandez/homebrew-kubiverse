# Homebrew formula for the bridge (rendered by packaging/render.sh on each release).
#   brew install jairofernandez/kubiverse/kubiverse-bridge
# (It used to be called k8s-bridge: formula_renames.json moves old installs.)
class KubiverseBridge < Formula
  desc "Bridge between Kubiverse (a voxel game) and your Kubernetes cluster"
  homepage "https://github.com/jairoFernandez/kubiverse"
  version "0.1.25"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.25/kubiverse-bridge-darwin-arm64"
      sha256 "ae4cec70314b1efd6bbe965247e7ec1ab20389a55b38b5d513f515f2fa7c7432"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.25/kubiverse-bridge-darwin-amd64"
      sha256 "310a0bd68752fed9fe32dfa93bee4f67422ba5cab175e61de159efcf4bf7464f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.25/kubiverse-bridge-linux-arm64"
      sha256 "1d1195c7669b7e9a80baf5716600a8da9fae43abafefbdb1cae85ff400a625c9"
    end
    on_intel do
      url "https://github.com/jairoFernandez/kubiverse/releases/download/v0.1.25/kubiverse-bridge-linux-amd64"
      sha256 "a9b89c65631b016b926fca36ba83641d07432ff0c3065d6ec0ba9ea60b966bf8"
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
