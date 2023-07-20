#
#  Be sure to run `pod spec lint SoftVision.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "Eigen"
  spec.version      = "3.4.0"
  spec.summary      = "Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = "Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms."

  spec.homepage     = "https://eigen.tuxfamily.org"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => "MPL2", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Eigen contributers" => ""}

  spec.source       = { :git => "https://gitlab.com/libeigen/eigen.git", :tag => "#{spec.version}" }
  

  spec.ios.deployment_target = "12.0"

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "**/*.hpp"      #"**/*.{h,hpp,}",
  spec.header_mappings_dir = '.'
#  spec.header_dir = './Eigen'
  
  spec.preserve_paths = './**'
#  spec.preserve_paths = "Eigen/*","Eigen/**/*"
  
#  spec.preserve_paths = './**'
#  spec.public_header_files = "*.{h, hpp}"
  spec.xcconfig = { #'CLANG_CXX_LIBRARY' => 'libstdc++',

  'HEADER_SEARCH_PATHS' => './Eigen' # To make angled quotes recursive.
#    'HEADER_SEARCH_PATHS' => '${PROJECT_DIR}' # To make angled quotes recursive.
#  'HEADER_SEARCH_PATHS' => '${PODS_ROOT}' # To make angled quotes recursive.
  }

end
