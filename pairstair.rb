class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.7.3"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.3/pairstair-darwin-arm64"
      sha256 "83b96fb684a563142e3abea3f1a2db3eb75eb0bd103d56ecfc7464b0f4e1afa6"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.3/pairstair-darwin-amd64"
      sha256 "bdb7d682c1b25c0257df6e3bbf8892638f8c4f805c7fde74fb265309aa9066fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.3/pairstair-linux-arm64"
      sha256 "93ae0af9bd3453ed825cd59bc90d898d125973413c27f1566f8a1442a2bfc5d4"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.3/pairstair-linux-amd64"
      sha256 "3ecba0e421e9838f50119d69619764bbc2db41bf766f2bcefaa924a8275d1a0d"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.3/pairstair.1"
    sha256 "d58c5372fe0fb332138991145ecd53b99f406fb6cd67475db03b90e8c43aa1b8"
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
