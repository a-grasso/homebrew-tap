require "language/python"

class Reflock < Formula
  include Language::Python::Shebang

  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "e512f084d835ad4a1530d995a630c7971949eb53d16fc87895e72c2c4d122d9d"
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
