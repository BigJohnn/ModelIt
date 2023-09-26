Pod::Spec.new do |spec|

  spec.name         = "Alembic"
  spec.version      = "1.8.5"
  spec.summary      = "Industrial Light and Magic, a division of Lucasfilm Entertainment Company Ltd."
  spec.homepage     = "https://github.com/alembic/alembic"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/alembic/alembic.git" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "include/**/**.{h}"

 spec.ios.vendored_library =  'lib/libAlembic.a', 'lib/libImath-3_1_d.29.8.0.a'
  
  spec.header_mappings_dir = 'include'
  spec.libraries = 'stdc++'
end
