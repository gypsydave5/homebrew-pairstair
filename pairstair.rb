class Pairstair < Formula
  desc "Pairing matrix generator"
  homepage "https://github.com/gypsydave5/pairstair"
  version "0.7.0"

  on_macos do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.0/pairstair-darwin-arm64"
      sha256 "df2d92fab9ac5ad00ebd9d44a02211c2d84f360ec2d5eb1b5fc925f082ca8394"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.0/pairstair-darwin-amd64"
      sha256 "552a96c7b3ded21f3c10ff5dc1b67edb9f182e2f1a070693f46b7e11409b8b40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.0/pairstair-linux-arm64"
      sha256 "8a83d2be39b301b843050fe60f737b4da31d69f4a10edca5bcbf3f719be94072"
    end

    on_intel do
      url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.0/pairstair-linux-amd64"
      sha256 "2bae17a95d98a97855e11f0543477c3dca1f8872a36b65a16cf01ec8d38726a3"
    end
  end

  resource "man" do
    url "https://github.com/gypsydave5/pairstair/releases/download/v0.7.0/pairstair.1"
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
