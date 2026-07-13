class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.11.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "2101fe86f0d1664ebec295434faeefd4c324b75fff48cd06cee9c62ec7b953e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.11.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "13161846557459db27623b7223025b4a8e7fd636a153b2affcf60f4250ba51de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.11.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "21f3f79838c80c9d5962725da10194f38293b32af5a6ca250174819928955953"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.11.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2f34ef6d12343ee1e50b1c9a1d6c175f91b593a7d423c774181cc9c61f686c77"
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
