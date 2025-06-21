class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.6"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.6/pairstair-darwin-arm64"
      sha256 "17dfe4271e1d3fea760f0c83a995e5c7baded17dc7be1b1d0d5c2a35ac71d4a8"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.6/pairstair-darwin-amd64"
      sha256 "d25f403f38d8ea3859ddc3c62e54824f9bd9088e6a75cb047f25b5805bdeb0f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.6/pairstair-linux-arm64"
      sha256 "e9478119ed83988afc5d6c213e1148866a21d52bb474d2145754a163c8c97b6c"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.6/pairstair-linux-amd64"
      sha256 "d7d47bb43198a96358c0de9abe4fba173208bf76b9dcd6881c4d9375ecfbeca8"
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
