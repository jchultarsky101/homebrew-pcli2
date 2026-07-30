class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.15.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "8e3e98dd10c8694a747da09d651f8e8dfad8105d29e1d7d6b4c62d8fe4895a22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.15.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "e6a212bf904aa244fb568decbd4f29e7fe7253caacbb3e0bf0c1e5ae0e72acdc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.15.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eba5b0980a90e39de8807da1840401daf3b4555632f82abcd011137ea63c64e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.15.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9ad6d514a5089d7ce570ac90771470b7a5d26e92d0da520cd93ef08a0e201817"
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
