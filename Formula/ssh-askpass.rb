require "formula"

class SshAskpass < Formula
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.0.2.tar.gz"
  sha1 "fb92e5be3222d391c20b821b8d489fa896c32976"

  def install
    bin.install "ssh-askpass"
  end

  def caveats; <<-EOF.undent
    In order to use ssh-askpass you have to link the binary to where the ssh-agent
    is looking.

    For OS X pre 10.11:

        sudo ln -s /usr/local/bin/ssh-askpass /usr/libexec/ssh-askpass

    For OS 10.11+:

        Disable SIP (rootless) http://www.imore.com/el-capitan-system-integrity-protection-helps-keep-malware-away

        sudo mkdir -p /usr/X11R6/bin
        sudo ln -s $PWD/ssh-askpass /usr/X11R6/bin/ssh-askpass
        chmod +x /usr/X11R6/bin/ssh-askpass

        Enable SIP (rootless) http://www.imore.com/el-capitan-system-integrity-protection-helps-keep-malware-away

    NOTE: When uninstalling ssh-askpass the symlink needs to be removed manually.
    EOF
  end
end

