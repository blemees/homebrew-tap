class BlemeesAgent < Formula
  include Language::Python::Virtualenv

  desc "Headless agent daemon — Claude Code, Codex over a Unix socket"
  homepage "https://github.com/blemees/blemees-agent"
  license "MIT"

  url "https://github.com/blemees/blemees-agent/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "d4612ce36cd8465537df51a9a1f70f86fb0a02145e593cf19a881dd2ab0a0bcc"
  head "https://github.com/blemees/blemees-agent.git", branch: "main"

  # Runtime: stdlib-only; we just need a working Python.
  # Tracks the latest stable Python in Homebrew. CI exercises 3.11/3.12/3.13
  # so the daemon itself runs fine on whichever interpreter the user has.
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  # Default service definition so `brew services start blemees-agent` works.
  #
  # LaunchAgents (and systemd --user) run with a minimal PATH that does
  # not include the caller's shell paths. `claude` is commonly installed
  # to `~/.local/bin/claude` by the standalone installer, so we extend
  # PATH to find it without requiring extra setup. Users whose `claude`
  # lives elsewhere can set BLEMEES_AGENTD_CLAUDE to an absolute path via
  # `launchctl setenv BLEMEES_AGENTD_CLAUDE /full/path/to/claude` (macOS) or
  # a systemd drop-in (Linux) before starting the service.
  service do
    run [opt_bin/"blemees-agentd"]
    keep_alive true
    log_path       var/"log/blemees/agentd.log"
    error_log_path var/"log/blemees/agentd.err.log"
    environment_variables PATH: "#{Dir.home}/.local/bin:#{Dir.home}/bin:#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  test do
    # Smoke: --version exits 0 and prints the installed version.
    assert_match "blemees-agentd #{version}", shell_output("#{bin}/blemees-agentd --version")
  end
end
