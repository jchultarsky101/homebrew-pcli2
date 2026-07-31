class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.18.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.18.1/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "5bfc1133956394e68f23ba22a41cf5d6f759d02ee762532a8023f5dba16e8dc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.18.1/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "844bd1652d1991f36e5292d00f05f534009607269ad3ae82de31b1aa8e158d32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.18.1/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cb3197787cffaeb0c937cd72814a68b1e71c2ba46e03c51b90be64a42b22d9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.18.1/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca9b83e90fbdf6529864cc06af6494d10ddfb19bf92f029ed1eaf5d9243604fc"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "pcli2" if OS.mac? && Hardware::CPU.arm?
    bin.install "pcli2" if OS.mac? && Hardware::CPU.intel?
    bin.install "pcli2" if OS.linux? && Hardware::CPU.arm?
    bin.install "pcli2" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
