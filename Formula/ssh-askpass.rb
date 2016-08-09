require 'formula'

# Homebrew formula to install ssh password asker
class SshAskpass < Formula
  homepage 'https://github.com/tmaher/ssh-askpass/'
  url 'https://codeload.github.com/tmaher/ssh-askpass/tar.gz/v1.1.0'
  sha1 '640ce363c14fbebad637ee95a1dc875267158095'

  def install
    bin.install 'ssh-askpass'
  end

  def plist; <<-EOS.undent
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>#{plist_name}</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/ssh-agent</string>
		<string>-l</string>
	</array>
	<key>Sockets</key>
	<dict>
		<key>Listeners</key>
		<dict>
			<key>SecureSocketWithKey</key>
			<string>SSH_AUTH_SOCK</string>
		</dict>
	</dict>
    <key>EnableTransactions</key>
    <true/>
    <key>EnvironmentVariables</key>
    <dict>
        <key>SSH_ASKPASS</key>
        <string>#{opt_bin}/ssh-askpass</string>
        <key>DISPLAY</key>
        <string>https://github.com/openssh/openssh-portable/blob/94141b7/readpass.c#L144-L156</string>
    </dict>
</dict>
</plist>
    EOS
  end

  def caveats; <<-EOF.undent
    For now, you need to load your keys by hand (actual path to key may vary):

      ssh-add -c $HOME/.ssh/id_rsa

    TODO: add support for loading keys with Keychain passwords
    The LaunchAgent is because we need to hook ssh-agent's environment. Ignore
    the instruction to `launchctl load`; you have to log out/back in.
    EOF
  end
end
