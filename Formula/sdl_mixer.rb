class SdlMixer < Formula
  desc "Sample multi-channel audio mixer library"
  homepage "https://www.libsdl.org/projects/SDL_mixer/release-1.2.html"
  url "https://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz"
  sha256 "1644308279a975799049e4826af2cfc787cad2abb11aa14562e402521f86992a"
  license "Zlib"
  revision 6

  head do
    url "https://github.com/libsdl-org/SDL_mixer.git", branch: "SDL-1.2"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "flac"
  depends_on "libmikmod"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl12-compat"

  # Source file for sdl_mixer example
  resource "playwave" do
    url "https://github.com/libsdl-org/SDL_mixer/raw/1a14d94ed4271e45435ecb5512d61792e1a42932/playwave.c"
    sha256 "92f686d313f603f3b58431ec1a3a6bf29a36e5f792fb78417ac3d5d5a72b76c9"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_mixer/commit/a3e5ff8142cf3530cddcb27b58f871f387796ab6.diff"
    sha256 "334e10529313a7d30c75a547fcd8392a7b8cdd736eaddb5c2820a877dfc835a4"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_mixer/commit/9e6d7b67a00656a68ea0c2eace75c587871549b9.diff"
    sha256 "49bcbd98375e6febcfdaf7926beb14b84f9b92a0ec4d0c38668d62666c377017"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_mixer/commit/d28cbc34d63dd20b256103c3fe506ecf3d34d379.diff"
    sha256 "e33a7b1b4d143b34d26965825aca535ea5ed77cba986e91026b769c397436521"
  end

  patch do
    url "https://github.com/libsdl-org/SDL_mixer/commit/05b12a3c22c0746c29dc5478f5b7fbd8a51a1303.diff"
    sha256 "d31a0544af94ac2a78aa55219c87644e496b85d9968ace3680ec51f3a09d0975"
  end

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

  test do
    testpath.install resource("playwave")
    cocoa = []
    cocoa << "-Wl,-framework,Cocoa" if OS.mac?
    system ENV.cc, "playwave.c", *cocoa, "-I#{include}/SDL",
                   "-I#{Formula["sdl12-compat"].opt_include}/SDL",
                   "-L#{lib}", "-lSDL_mixer",
                   "-L#{Formula["sdl12-compat"].lib}", "-lSDLmain", "-lSDL",
                   "-o", "playwave"
    Utils.safe_popen_read({ "SDL_VIDEODRIVER" => "dummy", "SDL_AUDIODRIVER" => "disk" },
                          "./playwave", test_fixtures("test.wav"))
    assert_predicate testpath/"sdlaudio.raw", :exist?
  end
end