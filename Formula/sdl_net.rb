class SdlNet < Formula
  desc "Sample cross-platform networking library"
  homepage "https://www.libsdl.org/projects/SDL_net/release-1.2.html"
  url "https://www.libsdl.org/projects/SDL_net/release/SDL_net-1.2.8.tar.gz"
  sha256 "5f4a7a8bb884f793c278ac3f3713be41980c5eedccecff0260411347714facb4"
  revision 1

  head do
    url "https://github.com/libsdl-org/SDL_net.git", branch: "SDL-1.2"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "sdl12-compat"

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--disable-sdltest"
    system "make", "install"
  end
end
