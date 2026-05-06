class Portbook < Formula
  desc "Local web dashboard that auto-discovers and labels HTTP dev services running on localhost ports."
  homepage "https://github.com/a-grasso/portbook"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.3/portbook-aarch64-apple-darwin.tar.xz"
      sha256 "26601660ef3c2f38a995d3129b431c1701f1acb02a01b9e8907d2a0d41b5be4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.3/portbook-x86_64-apple-darwin.tar.xz"
      sha256 "19d7b3dd53f2a371bd12916fe15dce54491851ee3c601db8957e70a060666190"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.3/portbook-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "628003a775f6d5baebcad624dde20d308efe7a503713e4fefe639322fd22e72c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.3/portbook-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "14089eb9061c440f95548d93ac4c4ea9181162c9898264191ba30aea17000bf9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "portbook" if OS.mac? && Hardware::CPU.arm?
    bin.install "portbook" if OS.mac? && Hardware::CPU.intel?
    bin.install "portbook" if OS.linux? && Hardware::CPU.arm?
    bin.install "portbook" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
