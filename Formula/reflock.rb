require "language/python"

class Reflock < Formula
  include Language::Python::Shebang

  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "f5a6f510c7636200e0892eb546579317facdbf96c0030da6c6286fb95ea92a0a"
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
