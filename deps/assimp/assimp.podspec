Pod::Spec.new do |spec|

  spec.name         = "assimp"
  spec.version      = "5.3.0"
  spec.summary      = "Open Asset Import Library is a library to load various 3d file formats into a shared, in-memory format."
  spec.homepage     = "https://github.com/assimp/assimp"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/assimp/assimp.git" }
  spec.ios.deployment_target = "12.0"
  
  spec.source_files = "include/**/**.{hpp}","include/**/**.{h}","include/**/**.{inl}"

  spec.ios.vendored_library =  'lib/libassimp.5.3.0.a'
  
  spec.header_mappings_dir = 'include'
  spec.libraries = 'stdc++'
end
