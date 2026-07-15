require "language/python"

class Reflock < Formula
  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "58c9c62f917b9e4cb34401641cf866f572f31ea6f1b4a1408e565a2a83870118"
  license "MIT"

  depends_on "python@3.13"

  def install
    bin.install "reflock.py" => "reflock"
    rewrite_shebang detected_python_shebang, bin/"reflock"
  end

  test do
    assert_match "usage: reflock", shell_output("#{bin}/reflock --help")
  end
end
