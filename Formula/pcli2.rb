class Pcli2 < Formula
  desc "CLI client for the Physna public API - Advanced 3D Geometry Search and Analysis"
  homepage "https://jchultarsky101.github.io/pcli2/"
  version "1.24.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.24.0/pcli2-aarch64-apple-darwin.tar.xz"
      sha256 "f6c95b1657b3e16cedfd6740a83a45fc3e20163fc1e03fc30ff1026bb86819aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.24.0/pcli2-x86_64-apple-darwin.tar.xz"
      sha256 "b39be4219cfd45e00ac81dcd73f5b41931e67d593ce601eb5dc217f1e36ac9d8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.24.0/pcli2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "393539347e9104e1322795dec46017f33da495ac3512138fa9dd43665b3d2145"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky101/pcli2/releases/download/v1.24.0/pcli2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eccc54f2b0acbb144e9e92f0f876a124c1ef6aee119877eb0d408e992c2e4fea"
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
