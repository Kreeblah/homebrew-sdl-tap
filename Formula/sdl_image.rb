class SdlImage < Formula
  desc "Image file loading library"
  homepage "https://github.com/libsdl-org/SDL_image"
  url "https://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.12.tar.gz"
  sha256 "0b90722984561004de84847744d566809dbb9daf732a9e503b91a1b5a84e5699"
  license "Zlib"
  revision 10

  head do
    url "https://github.com/libsdl-org/SDL_image.git", branch: "SDL-1.2"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "sdl12-compat"
  depends_on "webp"

  patch do
    url "https://github.com/libsdl-org/SDL_image/commit/019f68f9f9460bdc37e5098d360ebc85758cae5c.diff"
    sha256 "ccc6631adfd10f4265156cf88666bea974aa304996d2efcebf3ade3074312a9f"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_image/commit/1c1755efa690e0998a33b6ae4af1bb526f5a6e2c.diff"
    sha256 "21af348fb1ac5609fb63cdfbf7850d4d6407b4a5809a408f8e26802958ef84e0"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_image/commit/abb2c39f0326bd5ec3ebde314907c71a8487e997.diff"
    sha256 "1d496f6817ccf5a8e5b63ae135e0a8ee09cbefdcabcf5115d4452d9fb82574db"
  end

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
