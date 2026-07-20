class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.12.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "c0a598036bbc4f1a9b0d70a35b3d30d25cb5e7e854938257cbd85c82107e748e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.12.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "b5b59b841821de66f70c42a439df4c4adf532ea807d7f5ca0b2d198dbf8ba819"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.12.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ed73fda65cd5257ac9d7ec151d42ce3edada1b120acd7642d15cb2bf4e14390a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.12.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c716ff1b6e221bd5a237575a99a3a290092f92b9c6ecfa8bce100a2e9adb1d40"
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
