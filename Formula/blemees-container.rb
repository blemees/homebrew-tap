class BlemeesContainer < Formula
  include Language::Python::Virtualenv

  desc "Run blemees-agentd inside a sandboxed container"
  homepage "https://github.com/blemees/blemees-container"
  license "MIT"

  # Updated automatically by .github/workflows/bump-tap.yml in
  # blemees/blemees-container on each tag push. Until the first
  # release, the URL points at a non-existent tag — `brew install`
  # won't work but the formula validates as Ruby and the bump-tap
  # workflow can rewrite both fields safely.
  url "https://github.com/blemees/blemees-container/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  head "https://github.com/blemees/blemees-container.git", branch: "main"

  # Stdlib-only CLI; needs a working Python. Tracks the latest stable
  # Python in Homebrew. CI exercises 3.11/3.12/3.13.
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "blemees-container #{version}",
                 shell_output("#{bin}/blemees-container --version")
  end
end
