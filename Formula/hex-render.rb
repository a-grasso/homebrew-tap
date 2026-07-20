class HexRender < Formula
  desc "Render a hexarch DSL file to an interactive architecture diagram"
  homepage "https://github.com/a-grasso/hexarch"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-aarch64-apple-darwin.tar.xz"
      sha256 "373a16a41bd1ade69a0ca1230519507131410911a61b4f3a7e9cf28006c56205"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-x86_64-apple-darwin.tar.xz"
      sha256 "2b48d26148f9b150f226b06eb8c5c17997601984618ed3441dcf1dabdc79d2cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "05cf53e3f4e015879b2505484636579e071386886ac0bdd72846665c064b97c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4da814972df14307f9d106ecb4731547eb3e0168c48991bff3f9b89248ef867a"
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
