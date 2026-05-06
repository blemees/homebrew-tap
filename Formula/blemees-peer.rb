class BlemeesPeer < Formula
  include Language::Python::Virtualenv

  desc "Peer messaging daemon — agents talk to each other over a Unix socket"
  homepage "https://github.com/blemees/blemees-peer"
  license "MIT"

  # Updated automatically by .github/workflows/bump-tap.yml in
  # blemees/blemees-peer on each tag push. Until the first release,
  # the URL points at a non-existent tag — `brew install` won't work
  # but the formula validates as Ruby and the bump-tap workflow can
  # rewrite both fields safely.
  url "https://github.com/blemees/blemees-peer/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ae182a74fa768c1b6f9e0b423e06268ee19fe086d6b386320cf522a92d1ca725"
  head "https://github.com/blemees/blemees-peer.git", branch: "main"

  # Stdlib-only daemon; needs a working Python. Tracks the latest
  # stable Python in Homebrew. CI exercises 3.11/3.12/3.13.
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  # `brew services start blemees-peer` runs the daemon under launchd /
  # systemd. The peer mesh is single-instance per user, so this is the
  # standard way to keep one alive in the background.
  service do
    run [opt_bin/"blemees-peerd"]
    keep_alive true
    log_path       var/"log/blemees/peerd.log"
    error_log_path var/"log/blemees/peerd.err.log"
  end

  test do
    assert_match "blemees-peerd #{version}", shell_output("#{bin}/blemees-peerd --version")
    assert_match "blemees-peer-mcp #{version}", shell_output("#{bin}/blemees-peer-mcp --version")
  end
end
