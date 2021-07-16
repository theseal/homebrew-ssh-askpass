class SshAskpass < Formula
  desc "The ssh-askpass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.2.3.tar.gz"
  sha256 "9eb9c71e1fd8e6f23057fd70e0438d6c0cc5983e9dfe248226865015b6f1b287"

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
