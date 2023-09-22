Pod::Spec.new do |spec|

  spec.name         = "lemon"
  spec.version      = "1.3"
  spec.summary      = "LEMON - a Library for Efficient Modeling and Optimization in Networks"
  spec.homepage     = "http://lemon.cs.elte.hu/trac/lemon"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "http://lemon.cs.elte.hu/trac/lemon" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "**/**.{h}"
  spec.public_header_files = "**/**.{h}"
   
  spec.ios.vendored_library = 'lib/liblemon.a'
  spec.libraries = 'z'
  
  
#  spec.header_dir = './lemon'
  
  spec.header_mappings_dir = 'include'
  spec.libraries = 'stdc++'
end
