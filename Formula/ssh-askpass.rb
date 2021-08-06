class SshAskpass < Formula
  desc "The ssh-askpass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.3.0.tar.gz"
  sha256 "a3023246504d35ddc7047f4bc609a5ed39bb601a8c0de57bc246bbdb2fa5f75e"

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
