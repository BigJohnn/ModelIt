Pod::Spec.new do |spec|

  spec.name         = "libyuv"
  spec.version      = "1832"
  spec.summary      = "libyuv is an open source project that includes YUV scaling and conversion functionality."
  spec.homepage     = "https://chromium.googlesource.com/libyuv/libyuv.html"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://chromium.googlesource.com/libyuv/libyuv" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "**/**.{h}"
  spec.public_header_files = "**/**.{h}"
  spec.ios.vendored_library = 'libyuv.a'
  
  spec.header_mappings_dir = 'include'
#  spec.header_dir = 'include'

end
