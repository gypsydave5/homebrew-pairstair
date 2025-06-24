class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.18"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.18/pairstair-darwin-arm64"
      sha256 "e4c1b99b599e69b8eb6dcb98bebce4bd166bb357c870345343515b58efc1f73d"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.18/pairstair-darwin-amd64"
      sha256 "c7a86927b141590dadde756ac7a6c6ec99f7e7eaf9bdb440ba93936d802b0cfb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.18/pairstair-linux-arm64"
      sha256 "36feb399ec23c820d9da5024362ce04eb5a2dff86ed52488e06be879e3e4946f"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.18/pairstair-linux-amd64"
      sha256 "7b7a74c0954ec016fc35bc731a10e6c0b4a060f70870033f81761b138a257924"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.18/pairstair.1"
    sha256 "98d13e845703952c238e1db3ec14fcd18de7f4acecbff982665bdaf6853f3184"
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
