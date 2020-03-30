#
# Be sure to run `pod lib lint BaseWithRAC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLShareSDK'
  s.version          = '0.1.0'
  s.summary          = 'DLShareSDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'DLShareSDK local'

  s.homepage         = 'https://github.com/LiYang/BaseWithRAC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiYang' => '308689786@qq.com' }
  s.source           = { :git => 'https://github.com/LiYang/DLShareSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'DLShareSDK/Classes/**/*'
  
  s.resource_bundles = {
    'DLShareSDK' => ['DLShareSDK/Assets/*.png']
  }

  s.vendored_frameworks = 'DLShareSDK/Lib/*.framework'

  s.libraries = 'sqlite3', 'iconv'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'DLUIKit', '~> 0.1.0'
  s.dependency 'DLUtls', '~> 0.1.0'
  s.dependency 'Masonry', '~> 0.6.0'
  s.dependency 'WeXSDK', '~> 0.1.0'

end
