class Imdupes < Formula
  include Language::Python::Virtualenv

  desc "Versatile image deduplicator"
  homepage "https://github.com/miketvo/imdupes"
  url "https://github.com/miketvo/imdupes/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "480dc17e1d87e56167459bf426c8e22b5ea0f91afb54b7c01cd89d7ae9e82d48"
  license "GPL-3.0-only"
  head "https://github.com/miketvo/imdupes.git", branch: "dev"

  depends_on "python@3.11"

  def install
    venv_dir = libexec/"venv"
    venv_dir.mkpath

    system Formula["python@3.11"].opt_bin/"python3", "-m", "venv", venv_dir
    venv_python = venv_dir/"bin/python"
    venv_pip = venv_dir/"bin/pip"

    system venv_pip, "install", "-r", buildpath/"requirements.txt"

    system venv_python, "build.py"
    bin.install "dist/imdupes" => "imdupes"
  end

  test do
    assert_match "imdupes", shell_output(bin/"imdupes --version")
    assert_match "Quickly detects and removes identical images.", shell_output(bin/"imdupes --help")
  end
end
