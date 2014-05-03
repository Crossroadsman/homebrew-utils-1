require "formula"

class Up < Formula
  homepage 'https://github.com/bfontaine/up#readme'
  url "https://github.com/bfontaine/up/archive/0.1.3.tar.gz"
  sha1 "17b8676661f717db025ca62f9ac7e4c682f32a26"

  def install
    bin.install 'bin/up'
  end

  test do
    ENV['COMMANDS'] = pwd/'foo'
    touch 'foo'
    system "#{bin}/up", "--add", "x", "ls"
    system "#{bin}/up", "x"
    system "#{bin}/up", "--rm", "x"
  end
end
