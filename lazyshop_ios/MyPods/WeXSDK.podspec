#
# Be sure to run `pod lib lint DLUtls.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WeXSDK'
  s.version          = '0.1.0'
  s.summary          = 'WeXSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'WeXSDK Local'

  s.homepage         = 'https://github.com/LiYang/WeXSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiYang' => '308689786@qq.com' }
  s.source           = { :git => 'https://github.com/LiYang/WeXSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'WeXSDK/Classes/**/*'
  
  s.resource_bundles = {
    'WeXSDK' => ['WeXSDK/Assets/*.png']
  }

  s.ios.vendored_libraries = 'WeXSDK/Lib/*.a'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'SystemConfiguration', 'Security', 'CoreGraphics', 'CoreTelephony'
  s.libraries = 'z','sqlite3','stdc++'

end
