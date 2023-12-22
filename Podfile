use_frameworks!

platform :ios, '12.0'


install! 'cocoapods', :deterministic_uuids => false

target 'ModelIt' do
  pod 'glog', :path => './deps/glog'
  
  pod 'Alembic', :path => './deps/Alembic'
  
  pod 'assimp', :path => './deps/assimp'
  
  pod 'mtlkernels', :path => './deps/mtlkernels', :inhibit_warnings => true
  
  pod 'SoftVision', :path => './deps/SoftVision', :inhibit_warnings => true
  
  pod 'openmp', :path => './deps/openmp', :inhibit_warnings => true
  
  pod 'flann', :path => './deps/flann', :inhibit_warnings => true
  
  pod 'lemon', :path => './deps/lemon'
#
  pod 'Eigen', :path => './deps/eigen3'#, :inhibit_warnings => true
  
  pod 'OpenImageIO', :path => './deps/OpenImageIO', :inhibit_warnings => true
#
#  pod 'test', :path => './deps/test'#, :inhibit_warnings => true
  
  pod 'VLFeat', :path => './deps/VLFeat', :inhibit_warnings => true
  
  pod 'libpng', :path => './deps/libpng'
  
  pod 'libyuv', :path => './deps/libyuv'
  
  pod 'Ceres', :path => './deps/Ceres'
  
  pod 'cJSON', :path => './deps/cJSON'
  
  
  
end

dynamic_frameworks = ['mtlkernels'] # <- swift libraries names

# Make all the other frameworks into static frameworks by overriding the static_framework? function to return true
pre_install do |installer|
  installer.pod_targets.each do |pod|
    if !dynamic_frameworks.include?(pod.name)
      puts "Overriding the static_framework? method for #{pod.name}"
      def pod.static_framework?;
        true
      end
      def pod.build_type;
        Pod::BuildType.static_library
      end
    end
  end
end
