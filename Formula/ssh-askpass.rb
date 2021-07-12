class SshAskpass < Formula
  desc "The ssh-askpass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.2.2.tar.gz"
  sha256 "a32e8bccbe44adddab3192cc4263d2c2d7f0fc2613ee80be4fcf46e233cea970"

  def install
    bin.install "#{name}"
    prefix.install "#{name}.plist" => "#{plist_name}.plist"
  end

  def caveats; <<~EOF
    NOTE: You will need to run the following to load the SSH_ASKPASS environment variable:
      brew services start #{name}
    EOF
  end

  test do
    system "true"
  end
end
