require 'formula'

# Homebrew formula to install ssh password asker
class SshAskpass < Formula
  homepage 'https://github.com/tmaher/ssh-askpass/'
  url 'https://codeload.github.com/tmaher/ssh-askpass/tar.gz/v1.1.0'
  sha256 'fc140cfb914c44cae449b96e2082ac13adbc02c3cd5a7fd837bc009a2bbc9c27'

  DISPLAY_TEXT='https://github.com/openssh/openssh-portable/blob/94141b7/readpass.c#L144-L156'.freeze

  def install
    bin.install 'ssh-askpass'
  end

  def plist; <<-EOS.undent
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/sh</string>
      <string>-c</string>
      <string>
        /bin/launchctl setenv SSH_ASKPASS \"#{opt_bin}/ssh-askpass\"
        if [ -z $DISPLAY ]; then
          /bin/launchctl setenv DISPLAY \"#{DISPLAY_TEXT}\"
        fi
        if [ -x \"#{opt_bin}/go-ssh-add\" ]; then
          \"#{opt_bin}/go-ssh-add\" add-all
        fi
      </string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>
    EOS
  end

  def caveats; <<-EOF.undent
    For now, you need to load your keys by hand (actual path to key may vary):

      ssh-add -c $HOME/.ssh/id_rsa

    The LaunchAgent is because we need to hook ssh-agent's environment. Ignore
    the instruction to `launchctl load`; you have to log out/back in.
    EOF
  end
end
