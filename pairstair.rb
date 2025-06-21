class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "v0.3.13"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.13/pairstair-darwin-arm64"
      sha256 "77eab63c73f74c0688b2122336cc7437d13a11a90507f54cd5cbae748de227a9"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.13/pairstair-darwin-amd64"
      sha256 "827ff1cefffd86c48a03977fca640413b4c5e2d286f5cb2ad964bae8d5253cbd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.13/pairstair-linux-arm64"
      sha256 "8a958faad77f49e2c7d565ff351bb89eaf3fa5c9fccbd7b27039b52e5bbd2485"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.13/pairstair-linux-amd64"
      sha256 "d3e36b85f4978e9dcec42fa75c2b646741046300b8534b7e8fb3d6ba582d9621"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.3.13/pairstair.1"
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
