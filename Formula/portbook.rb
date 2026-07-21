class Portbook < Formula
  desc "Local web dashboard that auto-discovers and labels HTTP dev services running on localhost ports."
  homepage "https://github.com/a-grasso/portbook"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.2/portbook-aarch64-apple-darwin.tar.xz"
      sha256 "3ff0274815fd12ee0025d39336146de8085cd83c4d95c7cb1a3dd3980a54c88b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.2/portbook-x86_64-apple-darwin.tar.xz"
      sha256 "0205a9cdc91e5fdafee87ae01779a2395549b2647274ab3f287561df8cc75b36"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.2/portbook-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7f7cb291a18ff47cd06bac698c34dbb243927c74a333c81e576a3dbf6efbf01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.2/portbook-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7217872674f35ae73a7f624d671af92242b2732e2d9afc2d5fef0c2f17dcda9c"
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
