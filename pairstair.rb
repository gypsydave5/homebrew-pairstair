class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.5.1"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.5.1/pairstair-darwin-arm64"
      sha256 "a74e20883af76b693ff08c8ed49bf4ecc0ae89445980cf08f26e5841d616d347"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.5.1/pairstair-darwin-amd64"
      sha256 "18fffb66f19bbf7140df365a00e82512500f3a469bed4f8bd68ddcc23f562388"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.5.1/pairstair-linux-arm64"
      sha256 "ae7897bee1c99c40f64b0eee94ce84a49c4b8935de801f49d42aff72fc460d2d"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.5.1/pairstair-linux-amd64"
      sha256 "c2213e757e931d3b47c2a5ca2e8630b2ae6eeea7a249f64a86e6bd2d63d35d15"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.5.1/pairstair.1"
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
