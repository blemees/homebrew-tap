class Blemees < Formula
  include Language::Python::Virtualenv

  desc "Headless agent daemon exposing `claude -p` over a Unix socket"
  homepage "https://github.com/blemees/blemees-daemon"
  license "MIT"
  revision 1

  url "https://github.com/blemees/blemees-daemon/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "e80c0a50e06272e76419f79fa87bba45a38f5ed84d03a9fb6a0e04c53ae321b3"
  head "https://github.com/blemees/blemees-daemon.git", branch: "main"

  # Runtime: stdlib-only; we just need a working Python.
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  # Default service definition so `brew services start blemees` works.
  #
  # LaunchAgents (and systemd --user) run with a minimal PATH that does
  # not include the caller's shell paths. `claude` is commonly installed
  # to `~/.local/bin/claude` by the standalone installer, so we extend
  # PATH to find it without requiring extra setup. Users whose `claude`
  # lives elsewhere can set BLEMEESD_CLAUDE to an absolute path via
  # `launchctl setenv BLEMEESD_CLAUDE /full/path/to/claude` (macOS) or
  # a systemd drop-in (Linux) before starting the service.
  service do
    run [opt_bin/"blemeesd"]
    keep_alive true
    log_path       var/"log/blemees/blemeesd.log"
    error_log_path var/"log/blemees/blemeesd.err.log"
    environment_variables PATH: "#{Dir.home}/.local/bin:#{Dir.home}/bin:#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  test do
    # Smoke: --version exits 0 and prints the installed version.
    assert_match "blemeesd #{version}", shell_output("#{bin}/blemeesd --version")
  end
end
