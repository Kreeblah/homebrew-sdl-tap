class SdlMixer < Formula
  desc "Sample multi-channel audio mixer library"
  homepage "https://www.libsdl.org/projects/SDL_mixer/release-1.2.html"
  url "https://github.com/libsdl-org/SDL_mixer.git",
      revision: "174ce82f4445c7a95cd021ee103135d04de83a7b"
  version "1.2.13-HEAD"
  license "Zlib"
  head "https://github.com/libsdl-org/SDL_mixer.git", branch: "SDL-1.2"

  depends_on "pkgconf" => :build
  depends_on "flac"
  depends_on "libmikmod"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl12-compat"

  def install
    inreplace "SDL_mixer.pc.in", "@prefix@", HOMEBREW_PREFIX

    system "./autogen.sh" if build.head?

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --enable-music-ogg
      --enable-music-flac
      --disable-music-ogg-shared
      --disable-music-mod-shared
    ]

    system "./configure", *args
    system "make", "install"
  end
end
