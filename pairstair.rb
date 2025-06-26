class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.4.1"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.1/pairstair-darwin-arm64"
      sha256 "eb0ec0adb74bbf652180aec8df857ac6d7b2af331281e91f93cbc3f72c6b123d"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.1/pairstair-darwin-amd64"
      sha256 "fc958c1f32129d74e092598c4ff1ca49d57f69bba767ddf2ceb65ecab4291b85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.1/pairstair-linux-arm64"
      sha256 "7d1bb252e3376aa91336f85ef0032174d58387168035f8bcd4de3de6b3551a55"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.1/pairstair-linux-amd64"
      sha256 "eb1eb155b08d1b8dacc9554cbebf2de650473bc2d2a8ecf1e4b02a32ed49bc74"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.1/pairstair.1"
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
