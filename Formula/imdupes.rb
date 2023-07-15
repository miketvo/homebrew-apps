class Imdupes < Formula
  include Language::Python::Virtualenv

  desc "Versatile image deduplicator. Inspired by fdupes."
  homepage "https://github.com/miketvo/imdupes"
  url "https://github.com/miketvo/imdupes/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "daa0af5383ead7193f1b788dafa6733ae2ed568f477c9c5d6be5ca6a67ee6be3"
  license "GPL-3.0-only"
  head "https://github.com/miketvo/imdupes/tree/dev"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3")
    ENV.prepend_path "PATH", venv.bin
    venv.pip_install_and_link Pathname.pwd

    system "python3", "build.py"
    bin.install "dist/imdupes" => "imdupes"
  end

  test do
    assert_match "imdupes",
                 shell_output(bin/"imdupes --version")
    assert_match "Quickly detects and removes identical images.",
                 shell_output(bin/"imdupes --help")
  end
end
