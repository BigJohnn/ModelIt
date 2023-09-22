Pod::Spec.new do |spec|

  spec.name         = "Ceres"
  spec.version      = "2.1.0"
  spec.summary      = "Ceres Solver is an open source C++ library for modeling and solving large, complicated optimization problems."
  spec.homepage     = "http://ceres-solver.org/"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "http://ceres-solver.org/" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "include/**/**.{h}"
  # spec.public_header_files = "**/**.{h}"
  spec.ios.vendored_library = 'lib/libceres.a'
  
  spec.ios.frameworks = 'Accelerate'
#  spec.header_dir = './include'
  
  spec.header_mappings_dir = 'include'
  spec.libraries = 'stdc++'
  spec.dependency 'glog'
end
