Pod::Spec.new do |spec|

  spec.name         = "glog"
  spec.version      = "0.0"
  spec.summary      = "Google Logging (glog) is a C++14 library that implements application-level logging. The library provides logging APIs based on C++-style streams and various helper macros."
  spec.homepage     = "https://github.com/google/glog"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/google/glog.git" }
  spec.ios.deployment_target = "12.0"
  
  spec.source_files = "include/**/**.{h}"

  spec.ios.vendored_library =  'lib/libglogbase.a'
  
  spec.header_mappings_dir = 'include'
  spec.libraries = 'stdc++'
end
