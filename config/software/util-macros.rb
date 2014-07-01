
name "util-macros"
default_version "1.18.0"

source :url => 'http://xorg.freedesktop.org/releases/individual/util/util-macros-1.18.0.tar.gz',
  :md5 => 'fd0ba21b3179703c071bbb4c3e5fb0f4'

relative_path 'util-macros-1.18.0'

configure_env =
  case Ohai['platform']
  when "aix"
    {
      "CC" => "xlc -q64",
      "CXX" => "xlC -q64",
      "LD" => "ld -b64",
      "CFLAGS" => "-q64 -I#{install_path}/embedded/include -O",
      "LDFLAGS" => "-q64 -Wl,-blibpath:/usr/lib:/lib",
      "OBJECT_MODE" => "64",
      "ARFLAGS" => "-X64 cru",
      "LD" => "ld -b64",
      "OBJECT_MODE" => "64",
      "ARFLAGS" => "-X64 cru "
    }
  when "mac_os_x"
    {
      "LDFLAGS" => "-L#{install_path}/embedded/lib -I#{install_path}/embedded/include",
      "CFLAGS" => "-I#{install_path}/embedded/include -L#{install_path}/embedded/lib"
    }
  when "solaris2"
    {
      "LDFLAGS" => "-R#{install_path}/embedded/lib -L#{install_path}/embedded/lib -I#{install_path}/embedded/include -static-libgcc",
      "CFLAGS" => "-L#{install_path}/embedded/lib -I#{install_path}/embedded/include"
    }
  else
    {
      "LDFLAGS" => "-L#{install_path}/embedded/lib -I#{install_path}/embedded/include",
      "CFLAGS" => "-I#{install_path}/embedded/include -L#{install_path}/embedded/lib"
    }
  end

build do
  command "./configure --prefix=#{install_path}/embedded", :env => configure_env
  command "make -j #{max_build_jobs}", :env => configure_env
  command "make -j #{max_build_jobs} install", :env => configure_env
end
