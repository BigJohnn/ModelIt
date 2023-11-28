Pod::Spec.new do |spec|

  spec.name         = "openmp"
  spec.version      = "16.0.6"
  spec.summary      = "FLANN is a library for performing fast approximate nearest neighbor searches in high dimensional spaces. It contains a collection of algorithms we found to work best for nearest neighbor search and a system for automatically choosing the best algorithm and optimum parameters depending on the dataset."
  spec.homepage     = "https://github.com/llvm/llvm-project/releases/tag/llvmorg-16.0.6"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/llvm/llvm-project/releases/tag/llvmorg-16.0.6" }
  spec.ios.deployment_target = "12.0"
  
  spec.source_files = "**/**.{h}"
  spec.public_header_files = "**/**.{h}"
  spec.ios.vendored_library = 'lib/libomp.a'
  
  spec.header_dir = 'include'

end
