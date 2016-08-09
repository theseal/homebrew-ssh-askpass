require 'formula'
require 'language/go'

# Homebrew formula for go-ssh-add
class GoSshAdd < Formula
  homepage 'https://github.com/tmaher/go-ssh-add/'
  url 'https://github.com/tmaher/go-ssh-add/archive/0.1.0.tar.gz'
  sha256 'fc140cfb914c44cae449b96e2082ac13adbc02c3cd5a7fd837bc009a2bbc9c27'
  depends_on 'go' => :build
  depends_on 'godep' => :build

  bottle do
    root_url 'https://github.com/tmaher/go-ssh-add/releases/download/0.1.0'

    cellar :any_skip_relocation
    sha256 '567fd532768ad4d7018e8fe943fbd018ed9b13372d22acc56d30d0425df52405' => :yosemite
    sha256 '9b756ec7e94b2d09e55ab701dfc1c972b1ef7183506b0ed8f10f81a89234a436' => :el_capitan
  end

  go_resource 'golang.org/x/crypto' do
    url 'https://go.googlesource.com/crypto.git',
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
      bin.install gopath/"bin/go-ssh-add"
    end
  end

  def caveats; <<-EOF.undent
    Add this to the end of your ~/.bashrc

    #{opt_bin}/go-ssh-add add-all
    EOF
  end
end
