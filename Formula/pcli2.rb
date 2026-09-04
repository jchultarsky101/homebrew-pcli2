class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.20.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "62bdff407c2cc7f4be349826b67e5811b2cbcc5dab987c78909a6a101cde1c4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.20.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "287d22a11a436176b7cb9d0a4fcdfc79324413442a617f82c2578fe70a043e2d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.20.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e2037b15ec3abe40d986a16d5ad26857bfa7cda9fbb833edd85384a7e9e53ea7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.20.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11944bca9da347046bdb608de1316ad501f7ad17b82eff0a05231feae03161d5"
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
