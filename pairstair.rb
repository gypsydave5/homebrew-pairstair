class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.8"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.8/pairstair-darwin-arm64"
      sha256 "1e45d42d357dc8e858cf8afd898399246bc85e73ef43cbc7d266512b7f87b219"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.8/pairstair-darwin-amd64"
      sha256 "37c95bdbcb76d77d8a4abe29fe3b64b656909103367c2e28ec73caf0eb57eb9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.8/pairstair-linux-arm64"
      sha256 "bede93f5c3a003f8498aa2576b6f3480c6391213642e4307218600162f01ae05"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.8/pairstair-linux-amd64"
      sha256 "ca14c0ff4837750af1345f44eada184140110ebd1c1ab72e2608a9ddbd4380a8"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.8/pairstair.1"
    sha256 "057578355a5be3bd0b051660f0181ee2c7739a88a05ecf62d928fcc8daf391b9"
  end

  def install
    arch = if OS.mac?
      Hardware::CPU.arm? ? "darwin-arm64" : "darwin-amd64"
    elsif OS.linux?
      Hardware::CPU.arm? ? "linux-arm64" : "linux-amd64"
    end

    bin_name = "pairstair"
    mv "pairstair-#{arch}", bin_name if File.exist?("pairstair-#{arch}")
    bin.install bin_name

    # Install man page
    man1.install resource("man")
  end
end
