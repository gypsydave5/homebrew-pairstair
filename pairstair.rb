class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.19"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.19/pairstair-darwin-arm64"
      sha256 "2a77b45d9bc07f97239ec70bf5aa584cd738e542f705130b5221eb21bde6591a"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.19/pairstair-darwin-amd64"
      sha256 "33ac65662074815116c0405168f8130bd13bbe11cd6929a7674414ac19424e61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.19/pairstair-linux-arm64"
      sha256 "8fb107a6fdba08691eea3dec90a1e3aaeb9da941ae8343eab15664e249bb0464"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.19/pairstair-linux-amd64"
      sha256 "f3cd1bc37a6590c59d0b01c09d15b52cdec4e8530482c9965e0b5e1de9f25e14"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.19/pairstair.1"
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
