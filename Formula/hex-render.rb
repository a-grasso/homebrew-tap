class HexRender < Formula
  desc "Render a hexarch DSL file to an interactive architecture diagram"
  homepage "https://github.com/a-grasso/hexarch"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-aarch64-apple-darwin.tar.xz"
      sha256 "da2f575188771ad6e1f326452e1770c4739dea40568f7c433d4f7dd9d922ef4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-x86_64-apple-darwin.tar.xz"
      sha256 "f7c67d6a3b4d9d5a8e65e01ca48819e970dd19dbd9449925db5be0284557642a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9536d64e9b3e61a452512d5676d0525ab273f6db940f64012c12edbe9e007427"
    end
    if Hardware::CPU.intel?
      url "https://github.com/a-grasso/hexarch/releases/download/v0.1.1/hex-render-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f3aea4966886bd72741776eb7e048a690619c64aa483652bceeae22878cb58a"
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
