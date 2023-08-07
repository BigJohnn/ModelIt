Pod::Spec.new do |spec|

  spec.name         = "Eigen"
  spec.version      = "3.4.0"
  spec.summary      = "Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms."
  spec.homepage     = "https://eigen.tuxfamily.org"
  spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "Benoît Jacob" => "",
    "Gaël Guennebaud" => "",
    "The Other Contributers ..." => "..."
  }

  spec.source       = { :git => "https://gitlab.com/libeigen/eigen.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "12.0"
#  spec.source_files  = "**/**.{h,hpp}"
#  spec.source_files  = ""
  spec.preserve_paths = './Eigen/**'
  spec.compiler_flags = '-DEIGEN_MPL2_ONLY'
  spec.header_mappings_dir = 'Eigen/*'
  
#  spec.preserve_paths = "Eigen/*","Eigen/**/*","unsupported/*","unsupported/**/*"
  
#  spec.header_dir = 'Eigen/*'
#  spec.project_header_files = "'Eigen/src/*"
  
  spec.ios.resource_bundle = { 'Eigen' => 'Eigen/src' }
  spec.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_ROOT)/Eigen"' }
  
#  spec.resources = [
#    "Eigen/*",
#    "unsupported/Eigen/*"
#  ]
#  spec.public_header_files = [
#  "Eigen/**"
#  ]

end
