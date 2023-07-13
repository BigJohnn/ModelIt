Pod::Spec.new do |spec|

  spec.name         = "OpenImageIO"
  spec.version      = "2.5.2.0"
  spec.summary      = "The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline."
  spec.homepage     = "https://github.com/OpenImageIO/oiio"
  spec.license      = { :type => "Apache License Version 2.0", :file => "LICENSE" }

  spec.author       = {
    "Contributors to the OpenImageIO project" => ""
  }

  spec.source       = { :git => "https://github.com/OpenImageIO/oiio.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "12.0"
  spec.libraries  = "OpenImageIO_d","OpenImageIO_Util_d"

  spec.source_files  = "include/**/**.{h,hpp}"

  spec.xcconfig = {
  'HEADER_SEARCH_PATHS' => '${PROJECT_DIR}/../**',
  'LIBRARY_SEARCH_PATHS' => "$(SRCROOT)/deps/OpenImageIO/lib"
  }

end
