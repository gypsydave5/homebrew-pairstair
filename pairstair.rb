class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.7.1"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.1/pairstair-darwin-arm64"
      sha256 "7dfba7c358d0b0d6c27ab2034cd0bd2714a0982bc435682cae161ee3ac19c10f"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.1/pairstair-darwin-amd64"
      sha256 "7d89dcd6fa9040b8d5e5f9ab0121844ae9b5720c93b40e298779bac0dc605b48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.1/pairstair-linux-arm64"
      sha256 "6cdb606da03a15067749afdd7fa2dea5f7ca0c81c163a12885e7f9356e8d93f9"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.1/pairstair-linux-amd64"
      sha256 "3136040e32fa4bbd83fe9944b476a0a7d644beaae0189291136859d004017cb8"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.1/pairstair.1"
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
