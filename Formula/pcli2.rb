class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.0.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "1129917c513b704d4853ec6ccf55e01f2f99c8473a5736633c454fe95741d49a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.0.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "a9824a939b60134f3fcd17f2a2eba39ed72703fbbce487d2f84002532cbaa7e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.0.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "98358dad0718ffe067a19bbef1132facb2284aeeb07494820e162960f936f512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v2.0.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e90d844a57c6e51c46b82a363636b028f83a505e61b2866e9412505743fa94d4"
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
