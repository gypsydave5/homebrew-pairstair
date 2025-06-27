class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.6.0"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.6.0/pairstair-darwin-arm64"
      sha256 "71c05e1892f732271c25d00a48f6bdfdd7f7bf12d3b47efcb1a21aeacf9f084d"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.6.0/pairstair-darwin-amd64"
      sha256 "3dcf9ea6090711ed51123661aa4dd6382ca85fe26591824d4cb6387c944aca74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.6.0/pairstair-linux-arm64"
      sha256 "52ebf9c48b5a3d7d8634d8d05b390ed05840515f607793ba3f2c07c4824e4b1f"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.6.0/pairstair-linux-amd64"
      sha256 "32dc659cffed25257dbdfdc0a1bc57e6a64f7a1bc400887798dce1e9bcd3c7ba"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.6.0/pairstair.1"
    sha256 "4fa16ec50f6382ff70c2a234f614201c00d06fecc30e888b114d59733cd51abd"
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
