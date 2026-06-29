#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'x_user_agent'
  s.version          = '1.0.0'
  s.summary          = 'Retrieve device user agents in Flutter.'
  s.description      = <<-DESC
  Retrieve device user agents in Flutter.
                       DESC
  s.homepage         = 'https://github.com/melihcelik09'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'x_user_agent' => 'melihcelikcodes@gmail.com' }
  s.source           = { :path => '.' }  
  s.source_files = 'x_user_agent/Sources/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '6.1'
end
