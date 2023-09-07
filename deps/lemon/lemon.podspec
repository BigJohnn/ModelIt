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
  
  spec.source_files = "lemon/**/*.{h,cc}"
  
  # spec.exclude_files = "**/*.txt","src/cpp/flann/mpi/*{server,client}.cpp"
#  spec.public_header_files = 'Headers/Public/**/*.hpp'
  spec.header_dir = './lemon'
  
  spec.header_mappings_dir = 'lemon'

end
