require "formula"
require "language/go"

class GoSshAdd < Formula
  homepage "https://github.com/tmaher/go-ssh-add/"
  url "https://github.com/tmaher/go-ssh-add/archive/0.1.0.tar.gz"
  sha1 "412d9e865728abf953cd120ae941f120df892a98"
  depends_on "go" => :build
  depends_on "godep" => :build

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git",
      :revision => '5dc8cb4b8a8eb076cbb5a06bc3b8682c15bdbbd3'
  end

  go_resource "github.com/keybase/go-keychain" do
    url "https://github.com/keybase/go-keychain.git",
      :revision => '18e96b8b8ccf5706fbba9d97a82cbb009720bf02'
  end

  go_resource "github.com/codegangsta/cli" do
    url "https://github.com/codegangsta/cli.git",
      :revision => 'a2943485b110df8842045ae0600047f88a3a56a1'
  end

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/tmaher/go-ssh-add").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    Language::Go.stage_deps resources, gopath/"src"

    cd gopath/"src/github.com/tmaher/go-ssh-add" do
      system "go", "install"
      bin.install "bin/go-ssh-add"
    end
  end

  def caveats; <<-EOF.undent
    Add this to the end of your ~/.bashrc

    #{opt_bin}/go-ssh-add add-all
    EOF
  end
end
