class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.15"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.15/pairstair-darwin-arm64"
      sha256 "0d3c0bc1de5a5438d859cf0fd71c07ba2e735c275df5834c6dfc9c0a3da5a49d"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.15/pairstair-darwin-amd64"
      sha256 "04e095b7e212f2d13bdf21eac95bbaa22d7c70c320e2e962a436a86711930317"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.15/pairstair-linux-arm64"
      sha256 "8d1530fd485999894a545798740cb56a601ed8a8f0097dfeeb84e667388490ff"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.15/pairstair-linux-amd64"
      sha256 "3e127ac0d61d42acfcb72dfd685a0430eab8680e25b2c1913d59d344273b9812"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.15/pairstair.1"
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
