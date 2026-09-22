class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.2.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "98848ac838204763c78b04b834386b9db54bb095c0160d6c01a98181808eaa0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.2.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "b10a1231b32aa21d86787f4464e3c7800e7ad781180a64a4e0f28a4808a9b9e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.2.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ddce9c2c7cbcf97dfe061e1603630c433db9dc8a66ce5c00434e459891888175"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.2.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "efd1008a18c5aa9b7a6de5b39cf15c5ed9535226f845d7b2254a88fcb569f8a0"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pcli2"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pcli2"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pcli2"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pcli2"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
