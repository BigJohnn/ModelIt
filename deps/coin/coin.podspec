Pod::Spec.new do |spec|

  spec.name         = "coin"
  spec.version      = "0.0"
  spec.summary      = "Computational Infrastructure for Operations Research."
  spec.homepage     = "https://github.com/coin-or"

  spec.author       = {
    "" => ""
  }

  spec.source       = { :http => "https://github.com/coin-or.git" }
  spec.ios.deployment_target = "11.0"
  
  spec.source_files = "**/**"
  spec.exclude_files = "**/**.in", "**/**.txt", "**/**.sh", "**/**.am"
  
  spec.header_dir = '.'
  
  spec.header_mappings_dir = '.'
  
  # spec.dependency 'lemon'

end
