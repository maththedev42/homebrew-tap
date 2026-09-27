class Cosmokit < Formula
  desc "Drive iOS Simulator from command-line, with MCP server for coding agents"
  homepage "https://github.com/maththedev42/cosmokit-cli"
  url "https://github.com/maththedev42/cosmokit-cli/releases/download/v0.4.0/cosmokit-0.4.0-macos-universal.tar.gz"
  sha256 "a4216d3bab895e034608ebbe8f339fa06ce23a68896eebba0e697bbc1a967a76"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/cosmokit"
    pkgshare.install "share/cosmokit/Driver" => "Driver"
  end

  def caveats
    <<~EOS
      cosmokit shells out to `xcrun simctl`, so it needs Xcode's command line
      tools installed to do anything useful:

        xcode-select --install

      The UI driver is built with xcodebuild on first `cosmokit agent start`
      and requires full Xcode, not just command line tools.

      To connect with Claude Code:

        claude mcp add cosmokit -- cosmokit mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cosmokit version")
    assert_path_exists pkgshare/"Driver/project.yml"
  end
end
