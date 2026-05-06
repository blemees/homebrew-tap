class BlemeesTui < Formula
  include Language::Python::Virtualenv

  desc "Multi-session terminal chat — Claude Code + Codex side-by-side"
  homepage "https://github.com/blemees/blemees-tui"
  license "MIT"

  # Updated automatically by .github/workflows/bump-tap.yml in
  # blemees/blemees-tui on each tag push. Until the first release the
  # URL points at a non-existent tag.
  url "https://github.com/blemees/blemees-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5f21ffe0ec6c038383c99fb4134d03de6e7d941803ed515e57d225d62fcbddc7"
  head "https://github.com/blemees/blemees-tui.git", branch: "main"

  depends_on "python@3.13"

  # Runtime Python deps installed into the formula's virtualenv. The
  # `textual` resource block is added by `brew update-python-resources`
  # if you ever switch to a from-source build that needs vendored
  # wheels; for the standard install path we let pip resolve transitively
  # from the wheel's metadata.
  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "blemees #{version}", shell_output("#{bin}/blemees --version")
  end
end
