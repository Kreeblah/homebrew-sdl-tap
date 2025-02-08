class SdlNet < Formula
  desc "Sample cross-platform networking library"
  homepage "https://www.libsdl.org/projects/SDL_net/release-1.2.html"
  url "https://github.com/libsdl-org/SDL_net.git",
      revision: "0043be2e559f8d562d04bf62d6e3f4162ed8edad"
  version "1.2.9-HEAD"
  license "Zlib"

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
