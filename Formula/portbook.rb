class Portbook < Formula
  desc "Local web dashboard that auto-discovers and labels HTTP dev services running on localhost ports."
  homepage "https://github.com/a-grasso/portbook"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.0/portbook-aarch64-apple-darwin.tar.xz"
      sha256 "c9f7036b3962be5273d2f8ec278b6227f1a8b0e5b1d7957d228e5e8a703c0153"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.0/portbook-x86_64-apple-darwin.tar.xz"
      sha256 "f5eea579692dbce3170f821336927d7fe438af4667cd0e1d67cdc51bbc68f1ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.0/portbook-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3222fa8882022ba966605acb24c477e642f35bf1a4a2258cfda65ea1ee511fc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.2.0/portbook-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c844b26beffce5eab21aab7aefae74bec0c2dd3a8fa51e78d43ff26d5bf241eb"
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
