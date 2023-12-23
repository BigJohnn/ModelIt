Pod::Spec.new do |spec|

  spec.name         = "mtlkernels"
  spec.version      = "0.0"
  spec.summary      = "mtlkernels."
  spec.homepage     = "https://mtlkernels.todo.com"
  # spec.license      = { :type => "Mozilla Public License v2", :file => "LICENSE" }

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://mtlkernels.todo.git" }
  spec.ios.deployment_target = "13.0"
  
  spec.source_files = "**/**.{metal}"

  # spec.ios.vendored_library =  'lib/libglogbase.a'
  
  spec.header_mappings_dir = '.'
  spec.libraries = 'stdc++'
  spec.static_framework = false
  
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  
  spec.xcconfig = {
  'MTL_HEADER_SEARCH_PATHS' => '$(PROJECT_DIR)/Headers/Public/SoftVision'
  }
end
