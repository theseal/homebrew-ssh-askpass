require "formula"

class SshAskpass < Formula
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.0.2.tar.gz"
  sha256 "e83f27f016bd0aef360f361f7b6a373a345948fe71dd87807fc97be37c517742"

  def install
    bin.install "ssh-askpass"
  end

  def caveats; <<-EOF.undent
    In order to use ssh-askpass you have to link the binary to where the ssh-agent
    is looking.

    For OS X pre 10.11:

        sudo ln -s /usr/local/bin/ssh-askpass /usr/libexec/ssh-askpass

    For OS 10.11+:

        If you have XQuartz (http://www.xquartz.org/) or are willing to get it:

            Make sure that the latest XQuartz is installed. (eg. brew cask install xquartz)

            sudo ln -s /usr/local/bin/ssh-askpass /usr/X11R6/bin/ssh-askpass

        Else:

            Disable SIP (rootless) http://www.imore.com/el-capitan-system-integrity-protection-helps-keep-malware-away

            sudo mkdir -p /usr/X11R6/bin
            sudo ln -s /usr/local/bin/ssh-askpass /usr/X11R6/bin/ssh-askpass

            Enable SIP (rootless) http://www.imore.com/el-capitan-system-integrity-protection-helps-keep-malware-away

    NOTE: When uninstalling ssh-askpass the symlink needs to be removed manually.
    NOTE: If XQuartz is reinstalled you need to create the symlink again.
    EOF
  end
end

