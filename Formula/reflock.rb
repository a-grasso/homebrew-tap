require "language/python"

class Reflock < Formula
  include Language::Python::Shebang

  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "a2850e073d671b3cd5d38405e91106bef7616b1e49d1190faf82da2bf21d04a9"
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
