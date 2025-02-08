class SdlSound < Formula
  desc "Library to decode several popular sound file formats"
  homepage "https://icculus.org/SDL_sound/"
  url "https://github.com/icculus/SDL_sound.git",
      revision: "e525b7b4cbcb160e1d0392917d05df943608cc35"
  version "1.0.4-HEAD"
  license "LGPL-2.1-only"
  head "https://github.com/icculus/SDL_sound.git", branch: "stable-1.0"

  keg_only "it conflicts with `sdl2_sound`"

  depends_on "pkgconf" => :build
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl12-compat"

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    system "make"
    system "make", "install"
  end
end
