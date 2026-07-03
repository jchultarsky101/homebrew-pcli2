# Homebrew formula for PCLI2
# Install with:
#   brew tap jchultarsky101/pcli2
#   brew install pcli2
#
# Or directly:
#   brew install jchultarsky101/pcli2/pcli2
#
# This formula installs prebuilt binaries from the GitHub release.
# From the release after v1.9.0 it is maintained automatically by
# cargo-dist (Formula/pcli2.rb in this tap).

class Pcli2 < Formula
  desc "Physna Command Line Interface v2 - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.9.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.9.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "82e64e9c523dca522552d0b25b2894f1081edaa141d4624ab9be26d8a641feda"
    else
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.9.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "23e2955899bbe3572cf5c30656d4d38c737628cfcd74f5d3e2afa83316858245"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.9.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3aa1a593e7024b4ae062605661751e75ba60b3276279b5f6ee70df9799e3293f"
    else
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.9.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "761c94d4b03b4697838ada3a0dc4e588a16bce2651beb25819ee15e56fad299e"
    end
  end

  def install
    bin.install "pcli2"
    generate_completions_from_executable(bin/"pcli2", "completions")
  end

  test do
    assert_match "1.9.0", shell_output("#{bin}/pcli2 --version")

    output = shell_output("#{bin}/pcli2 --help")
    assert_match "Commands:", output
    assert_match "tenant", output
    assert_match "folder", output
    assert_match "asset", output
    assert_match "auth", output
  end
end
