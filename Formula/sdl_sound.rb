class SdlSound < Formula
  desc "Library to decode several popular sound file formats"
  homepage "https://icculus.org/SDL_sound/"
  url "https://icculus.org/SDL_sound/downloads/SDL_sound-1.0.3.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/s/sdl-sound1.2/sdl-sound1.2_1.0.3.orig.tar.gz"
  sha256 "3999fd0bbb485289a52be14b2f68b571cb84e380cc43387eadf778f64c79e6df"
  revision 2

  head do
    url "https://github.com/icculus/SDL_sound.git", branch: "stable-1.0"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only "it conflicts with `sdl2_sound`"

  depends_on "pkgconf" => :build
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl12-compat"

  patch do
    url "https://github.com/icculus/SDL_sound/commit/11acb6cd3a7744dc6f0383aa6ef0fe1a531b99aa.diff"
    sha256 "a28821936566129035441dd976e8863eba49bf3240413a8c7c80eaf5342ba4cb"
  end

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    system "make"
    system "make", "install"
  end
end
