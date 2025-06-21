class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.7"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.7/pairstair-darwin-arm64"
      sha256 "da34751e806d3c04a57d45671667b6fcce1a4e88747eeb48793ae75347ab2f25"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.7/pairstair-darwin-amd64"
      sha256 "3c66a83577758f081aca7a308ff51e0486ec03637c2f95fd4f3dc90b4e8ff374"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.7/pairstair-linux-arm64"
      sha256 "20f39108bcf9eebfddbee9da135034631182db060ae08fe51179e66474de22df"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.7/pairstair-linux-amd64"
      sha256 "2333c9f27ab77c9347bb2e1fedf298ce0b5a025948b6f043a4b9af2ba4bc7688"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.7/pairstair.1"
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
