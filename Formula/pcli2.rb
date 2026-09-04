class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.23.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.23.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "fe45cb171772536667f05dced8acb3c03bfae6d376851216c6b9b307d8351fd9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.23.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "d4e378ad921308f66fae5652a570b6fd36ff0c4d9633fc1685abfa2b1666ffb9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.23.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0823c1d729a39a5b254c6a36c0f7a5bb42207545734f6dcd093ce7aa1fc6a59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.23.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fdbd13ea43c45df238180c3c5b13400b7ea649b9fe224dd5cda6f07ffa16a6f0"
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
