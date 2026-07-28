require "language/python"

class Reflock < Formula
  include Language::Python::Shebang

  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "3ef8e424a590e41b10ad187091561408aa8ee84bdf961a9038c7711601e2b64c"
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
