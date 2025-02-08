class SdlTtf < Formula
  desc "Library for using TrueType fonts in SDL applications"
  homepage "https://github.com/libsdl-org/SDL_ttf"
  url "https://github.com/libsdl-org/SDL_ttf.git",
      revision: "3c4233732b94ce08d5f6a868e597af39e13f8b23"
  version "2.0.12-HEAD"
  license "Zlib"

  head do
    url "https://github.com/libsdl-org/SDL_ttf.git", branch: "SDL-1.2"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "freetype"
  depends_on "sdl12-compat"

  def install
    ENV.append "LDFLAGS", "-liconv" if OS.mac?
    inreplace "SDL_ttf.pc.in", "@prefix@", HOMEBREW_PREFIX

    system "./autogen.sh" if build.head?
    system "./configure", *std_configure_args, "--disable-sdltest"
    system "make", "install"
  end
end
