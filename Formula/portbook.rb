class Portbook < Formula
  desc "Local web dashboard that auto-discovers and labels HTTP dev services running on localhost ports."
  homepage "https://github.com/a-grasso/portbook"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.6/portbook-aarch64-apple-darwin.tar.xz"
      sha256 "59d5f5ba01dbf200e2f6b80c1ec72c0c25c68feb41208222099b9f7b2bf4912b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.6/portbook-x86_64-apple-darwin.tar.xz"
      sha256 "cc50b13c4804c640a823f3f31b4ee4c68a1cd2a581314fa921f6d61c30cc20cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.6/portbook-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0541eba7da705b610446bd2469196b4fd2176fef064532dd3071a124c78092e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/portbook/releases/download/v0.1.6/portbook-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0edb3a0ecf370469a3a579f4d09aee500418033c8912b80b53bbcb56b60a259b"
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
