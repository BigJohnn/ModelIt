Pod::Spec.new do |spec|

  spec.name         = "cJSON"
  spec.version      = "1.7.16"
  spec.summary      = "Ultralightweight JSON parser in ANSI C."
  spec.homepage     = "https://github.com/DaveGamble/cJSON"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/DaveGamble/cJSON/release" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "include/**.{h}"
  spec.public_header_files = "include/**.{h}"
  spec.ios.vendored_library = 'lib/libcjson.a'
  
  spec.header_mappings_dir = 'include'

end
