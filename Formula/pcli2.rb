class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.17.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "99b0e48c5f6334d116f74e60106a5fea41650b40f47383f4c26b0a7f04f0a1aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.17.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "c7c2719badde1d81063f21b91dfc5ef9cfeacb75d63acbf19093784c1c082fcf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.17.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b58345ff7efba2b0ba3289a1547b9dd231b29e7ef8027249398c5d07cbe41d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.17.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3075cbfa5920e10c066560eef09524f258f33ebe6e752954d19abf6b1fd3309"
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
