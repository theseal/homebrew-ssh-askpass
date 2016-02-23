require "formula"

class SshAskpass < Formula
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.0.2.tar.gz"
  sha1 "fb92e5be3222d391c20b821b8d489fa896c32976"

  def install
    bin.install "ssh-askpass"
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
    To use ssh-askpass, ssh-agent has to be started with some specific
    environment variables. To do that, run...

      cp #{plist_path} ~/Libraray/LaunchAgents

    and log out/in. Also you have to load your keys by hand
    Note: actual key locations may vary

      ssh-add -c $HOME/.ssh/id_rsa

    TODO: add support for loading keys with Keychain passwords
    EOF
  end
end
