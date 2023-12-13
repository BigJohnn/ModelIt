Pod::Spec.new do |spec|

  spec.name         = "flann"
  spec.version      = "1.8.4"
  spec.summary      = "FLANN is a library for performing fast approximate nearest neighbor searches in high dimensional spaces. It contains a collection of algorithms we found to work best for nearest neighbor search and a system for automatically choosing the best algorithm and optimum parameters depending on the dataset."
  spec.homepage     = "http://www.cs.ubc.ca/~mariusm/flann"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "http://people.cs.ubc.ca/~mariusm/uploads/FLANN/flann-1.8.4-src.zip" }
  spec.ios.deployment_target = "12.0"
  
  spec.source_files = "src/cpp/**/*.h","src/cpp/**/*.hpp","src/cpp/**/*.cpp"
  
  spec.exclude_files = "**/*.txt","src/cpp/flann/mpi/*{server,client}.cpp"
#  spec.public_header_files = 'Headers/Public/**/*.hpp'
  spec.header_dir = '.'
  
  spec.header_mappings_dir = 'src/cpp/flann'

end
