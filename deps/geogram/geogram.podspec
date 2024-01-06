Pod::Spec.new do |spec|

  spec.name         = "geogram"
  spec.version      = "1.8.6"
  spec.summary      = "Geogram is a programming library with geometric algorithms."

  spec.homepage     = "https://github.com/BrunoLevy/geogram"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/BrunoLevy/geogram.git" }
  spec.ios.deployment_target = "13.0"

  spec.source_files = "include/**/**.{hpp}","include/**/**.{h}"
  
  spec.header_mappings_dir = 'include'

  spec.ios.vendored_library = 'lib/libgeogram_third_party.a', 'lib/libgeogram.1.8.6.a'
end
