class HexRender < Formula
  desc "Render a hexarch DSL file to an interactive architecture diagram"
  homepage "https://github.com/a-grasso/hexarch"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.0/hex-render-aarch64-apple-darwin.tar.xz"
      sha256 "4b98343b405af8a1bcedbf09a389146ec5068dba1a108a94b7f95b6c5a906d32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.0/hex-render-x86_64-apple-darwin.tar.xz"
      sha256 "34bf499d652b1a816b799bd22d2bca9c06ea84ab40c5fe1357514d39afda37cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.0/hex-render-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5ed17f4585ac93c6b3efe1896c685ce067afeb08d716a9bb31d62eceaf58b799"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.0/hex-render-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "36d1447fc78d6716d685808186f56237b4918f2e979d3127c8118233e5055ab8"
    end
  end
  license "MIT"

  def install
    bin.install "hex-render"
  end

  test do
    assert_match "hex-render", shell_output("#{bin}/hex-render --help")
  end
end
