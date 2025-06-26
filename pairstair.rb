class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.0/pairstair-darwin-arm64"
      sha256 "0a05bc62c30ef96eddc378c40939fe3ee4dceb3e493349cc1de8a0ea326377ea"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.0/pairstair-darwin-amd64"
      sha256 "9f099494b5159a62d2a8187b2f4c0eb1633f6d8f73b74ba72bfb744a9d31efe5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.0/pairstair-linux-arm64"
      sha256 "857b10b3f0c4125bf9d201142a1b7fdb15b350e24e0d231bde8e9bb0fa1c16c6"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.0/pairstair-linux-amd64"
      sha256 "fe68d40f6040e40f1a86c34a351bbeab5bffb71ce464c0778a06f104b6a03093"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.4.0/pairstair.1"
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
