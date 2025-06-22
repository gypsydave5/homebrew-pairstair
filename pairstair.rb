class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.3.16"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.16/pairstair-darwin-arm64"
      sha256 "89472f61c3ad8ab381eb91139b84a45257cdc2b1a7b0b1fdc10573bd8eb63bc2"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.16/pairstair-darwin-amd64"
      sha256 "31fb6eb688f1433243eaeba9b9a0b91fd40cd1366b6c216ec1a058507214a0fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.16/pairstair-linux-arm64"
      sha256 "67fa9f7ec391c6239c067c1e61882b5c19508005f8789457e6d1b97f40f5cd6f"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.16/pairstair-linux-amd64"
      sha256 "848d51b5143b9dde1675795f41ae17fc49aa2c995cee1a05a23c9391d25df6cb"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.16/pairstair.1"
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
