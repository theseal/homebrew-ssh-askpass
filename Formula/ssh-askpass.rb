class SshAskpass < Formula
  desc "The ssh-askpass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.4.0.tar.gz"
  sha256 "9f13178d3856e7b280f8cc07bb7e755d8d1cd4ee4411fd48ffaa3235fcef9c32"

  # The label in the plist must be #{plist_name} in order for `brew services` to work
  # See https://github.com/Homebrew/homebrew-services/issues/376
  patch :DATA

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
__END__
diff --git a/ssh-askpass.plist b/ssh-askpass.plist
index af9ab75..d74d0b8 100644
--- a/ssh-askpass.plist
+++ b/ssh-askpass.plist
@@ -3,7 +3,7 @@
 <plist version="1.0">
     <dict>
         <key>Label</key>
-        <string>com.github.theseal.ssh-askpass</string>
+        <string>homebrew.mxcl.ssh-askpass</string>
         <key>LimitLoadToSessionType</key>
         <string>Aqua</string>
         <key>ProgramArguments</key>
