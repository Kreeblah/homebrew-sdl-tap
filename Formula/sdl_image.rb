class SdlImage < Formula
  desc "Image file loading library"
  homepage "https://github.com/libsdl-org/SDL_image"
  url "https://github.com/libsdl-org/SDL_image.git",
      revision: "3ae305b63db52b753333141d9536d23815a9f97f"
  version "1.2.13-HEAD"
  license "Zlib"

  head do
    url "https://github.com/libsdl-org/SDL_image.git", branch: "SDL-1.2"
  end

  depends_on "pkgconf" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "sdl12-compat"
  depends_on "webp"

  def install
    inreplace "SDL_image.pc.in", "@prefix@", HOMEBREW_PREFIX

    system "./autogen.sh" if build.head?

    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-imageio",
                          "--disable-jpg-shared",
                          "--disable-png-shared",
                          "--disable-sdltest",
                          "--disable-tif-shared",
                          "--disable-webp-shared"
    system "make", "install"
  end
end
