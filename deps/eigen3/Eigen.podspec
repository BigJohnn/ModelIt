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
  spec.source_files  = "**/**.{h,hpp}"

end
