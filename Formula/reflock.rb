require "language/python"

class Reflock < Formula
  include Language::Python::Shebang

  desc "Lockfile for cross-references in a mixed docs and code tree"
  homepage "https://github.com/a-grasso/reflock"
  url "https://github.com/a-grasso/reflock/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "40e7e312c08073504c0dc6e6bc5953603071eb5a18bc28b891a8528e60219a0b"
  license "MIT"

  depends_on "python@3.13"

  def install
    # reflock.py is the entry point, but the implementation lives in
    # the reflock_lib package beside it - installing the script alone
    # ships a command that dies on import. Both go to libexec; the
    # symlink into bin is safe because Python resolves it before
    # putting the script's directory on sys.path, which is the same
    # property install.sh relies on.
    libexec.install "reflock.py", "reflock_lib"
    rewrite_shebang detected_python_shebang, libexec/"reflock.py"
    bin.install_symlink libexec/"reflock.py" => "reflock"
  end

  test do
    # Exercising a real stamp/check round trip, not just --help: a
    # formula that ships an unimportable or unrunnable command must
    # fail here rather than in a user's terminal.
    assert_match "reflock #{version}", shell_output("#{bin}/reflock --version")
    (testpath/"t.md").write("# H\n\n## Decision\n\nWe chose X.\n")
    (testpath/"a.md").write("Per [d](t.md#decision)<!--@-->.\n")
    system bin/"reflock", "stamp"
    assert_match(/<!--@[0-9a-f]{8}-->/, (testpath/"a.md").read)
    system bin/"reflock", "check"
  end
end
