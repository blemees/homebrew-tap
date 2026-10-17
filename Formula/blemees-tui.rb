class BlemeesTui < Formula
  include Language::Python::Virtualenv

  desc "Multi-session terminal chat — Claude Code + Codex side-by-side"
  homepage "https://github.com/blemees/blemees-tui"
  # Updated automatically by .github/workflows/bump-tap.yml in
  # blemees/blemees-tui on each tag push.
  url "https://github.com/blemees/blemees-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5f21ffe0ec6c038383c99fb4134d03de6e7d941803ed515e57d225d62fcbddc7"
  license "MIT"
  head "https://github.com/blemees/blemees-tui.git", branch: "main"

  depends_on "python@3.13"

  # Runtime Python deps (blemees-agent, textual and their transitive deps).
  # virtualenv_install_with_resources runs pip with --no-deps, so every
  # dependency must be a resource. Regenerate with
  # `brew update-python-resources blemees-tui` when pyproject.toml changes.
  resource "blemees-agent" do
    url "https://files.pythonhosted.org/packages/1d/f0/ab403b24314952a70fb88a4eecd419c57f62deb8c6ad515aa8f56db4518f/blemees_agent-0.10.2.tar.gz"
    sha256 "9eac2d4834e3dc885af4210bd5d29ff674e3550415ac1e75d23e9653c86cfe2c"
  end

  resource "linkify-it-py" do
    url "https://files.pythonhosted.org/packages/45/98/7a1a5f31fd5c7ba93e963b168e244b8e3dd705b3d2a718e3c3307583bf57/linkify_it_py-2.2.0.tar.gz"
    sha256 "907acd2d17ac1fbb9ddb62c8957ccbd6158cac602231a15c3b0cd1e215f03cee"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdit-py-plugins" do
    url "https://files.pythonhosted.org/packages/59/fc/f8d0863f8862f25602c0404d75568e89fb6b4109804645e5cdfb1be5cf56/mdit_py_plugins-0.6.1.tar.gz"
    sha256 "a2bca0f039f39dbd35fb74ae1b5f998608c437463371f0ff7f49a19a17a114d0"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/05/7d/5f8821cccec8cad4ac57d3b373764c28ada31f3d7ac691a28b9e23ad6198/platformdirs-4.13.2.tar.gz"
    sha256 "7bea13e899d079e0a59b15ed7e481f8506dd1921df53afe23f4ae48eb3c117af"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "textual" do
    url "https://files.pythonhosted.org/packages/00/21/39a76b01bd5eea82a04baaca7580e105d8c59450df03998345bb2cfb307b/textual-8.2.8.tar.gz"
    sha256 "3f106a9fbc73e39dd266c9712432087de78a6d644084c7c241d6a25c3169115b"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "blemees-tui #{version}", shell_output("#{bin}/blemees --version")
    # --version does not import the app; import it so a missing runtime
    # dependency (e.g. textual) fails the test.
    system libexec/"bin/python", "-c", "import blemees_tui.app"
  end
end
