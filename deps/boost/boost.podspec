Pod::Spec.new do |spec|

  spec.name         = "boost"
  spec.version      = "1.83.0"
  spec.summary      = "The Boost project provides free peer-reviewed portable C++ source libraries."

  spec.homepage     = "https://www.boost.org"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://www.boost.org/users/download" }
  spec.ios.deployment_target = "13.0"

  spec.source_files = "include/**/**.{hpp}","include/**/**.{h}"
  
  spec.header_mappings_dir = 'include'

  
end
