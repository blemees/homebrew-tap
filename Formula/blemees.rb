class Blemees < Formula
  include Language::Python::Virtualenv

  desc "Headless Agent daemon exposing `claude -p` over a Unix socket"
  homepage "https://github.com/blemees/blemees-daemon"
  license "MIT"

  url "https://github.com/blemees/blemees-daemon/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3d6d97a2ce65225ba9d718a70a407cc95d7ae10bb6898f95a5dbe19071067a5f"
  head "https://github.com/blemees/blemees-daemon.git", branch: "main"

  # Runtime: stdlib-only; we just need a working Python.
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  # Default service definition so `brew services start blemees` works.
  service do
    run [opt_bin/"blemeesd"]
    keep_alive true
    log_path   var/"log/blemees/blemeesd.log"
    error_log_path var/"log/blemees/blemeesd.err.log"
  end

  test do
    # Smoke: --version exits 0 and prints the installed version.
    assert_match "blemeesd #{version}", shell_output("#{bin}/blemeesd --version")
  end
end
