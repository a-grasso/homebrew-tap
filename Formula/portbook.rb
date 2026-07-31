class Portbook < Formula
  desc "Local web dashboard that auto-discovers and labels HTTP dev services running on localhost ports."
  homepage "https://github.com/a-grasso/portbook"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.4/portbook-aarch64-apple-darwin.tar.xz"
      sha256 "48bf44350d1c4a7ddde7b1142a3e72f902d533085d4592bb0db287c1a3a455c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.4/portbook-x86_64-apple-darwin.tar.xz"
      sha256 "d2960eaadf8d6cc5e0f942020a44baf5f930a79ddc019d7dbb1f35f6be8114c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.4/portbook-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df34d84e123833f26367321f3dda085370b86d93bb2efefbd0426b92b9251a79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.4/portbook-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cd37b343aca6279a5d9a00ee9b2be0d427953a220b7cd31d63f1fc868b86ae55"
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
