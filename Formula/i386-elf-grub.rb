class I386ElfGrub < Formula
  desc "GNU GRUB 2 targetting i386-elf"
  homepage "https://www.gnu.org/software/grub/"
  url "https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz"
  sha256 "b79ea44af91b93d17cd3fe80bdae6ed43770678a9a5ae192ccea803ebb657ee1"
  revision 1

  depends_on "josefnatanael/i386-elf-toolchain/i386-elf-gcc"

  def install
    mkdir "grub-build" do
      ENV["CFLAGS"] = [ENV["CFLAGS"], "-Wno-incompatible-pointer-types"].compact.join(" ")

      system "../configure",
        "--disable-nls",
        "--disable-werror",
        "--disable-efiemu",
        "--target=i386-elf",
        "--prefix=#{prefix}",
        "TARGET_CC=i386-elf-gcc",
        "TARGET_NM=i386-elf-nm",
        "TARGET_OBJCOPY=i386-elf-objcopy",
        "TARGET_RANLIB=i386-elf-ranlib",
        "TARGET_STRIP=i386-elf-strip"

      system "make", "install"
    end
  end

  test do
    system "#{bin}/grub-file", "--usage"
  end
end
