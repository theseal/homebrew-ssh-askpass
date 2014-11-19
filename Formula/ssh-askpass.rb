require "formula"

class SshAskpass < Formula
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.0.1.tar.gz"
  sha1 "17b01f0eeba9257afc75a23654d28acf949cb3c8"

  def install
    bin.install "ssh-askpass"
  end

  def caveats; <<-EOF.undent
    In order to use ssh-askpass with ssh you have to link the binary to /usr/libexec:

    sudo ln -s /usr/local/bin/ssh-askpass /usr/libexec/ssh-askpass

    NOTE: When uninstalling ssh-askpass the symlink needs to be removed manually.
    EOF
  end
end

