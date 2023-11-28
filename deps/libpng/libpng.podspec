Pod::Spec.new do |spec|

  spec.name         = "libpng"
  spec.version      = "1.6.40"
  spec.summary      = "libpng is the official PNG reference library."
  spec.homepage     = "http://www.libpng.org/pub/png/libpng.html"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://sourceforge.net/projects/libpng/files/libpng16/1.6.40" }
  spec.ios.deployment_target = "12.0"
  
  spec.source_files = "**/**.{h}"
  spec.public_header_files = "**/**.{h}"
  spec.ios.vendored_library = 'lib/libpng.a'
  spec.libraries = 'z'
  
  spec.header_dir = 'include'

end
