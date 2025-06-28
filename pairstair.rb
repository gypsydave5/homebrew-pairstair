class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.7.2"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.2/pairstair-darwin-arm64"
      sha256 "124af3eecf5cb076c74f8e8662552f74520216740dbc734583d4be0e1c2ef8f8"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.2/pairstair-darwin-amd64"
      sha256 "6acb98ea36e367ffdf3cd0aaed496ed72b893652c3cb37c65a6b1b8bb451fa9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.2/pairstair-linux-arm64"
      sha256 "a522893221ab0a7e3f7757a0c35f264aadebb0c92541d47ce4fe50bf3708e72f"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.2/pairstair-linux-amd64"
      sha256 "ca099e35cc260a596da29b71298ee4228ec91f9dc96578f556a4df4a0d856a59"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.2/pairstair.1"
    sha256 "d58c5372fe0fb332138991145ecd53b99f406fb6cd67475db03b90e8c43aa1b8"
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
