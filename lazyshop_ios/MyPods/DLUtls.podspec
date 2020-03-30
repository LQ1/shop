#
# Be sure to run `pod lib lint DLUtls.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLUtls'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DLUtls.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LiYang/DLUtls'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiYang' => '308689786@qq.com' }
  s.source           = { :git => 'https://github.com/LiYang/DLUtls.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'DLUtls/Classes/**/*'
  
  s.resource_bundles = {
    'DLUtls' => ['DLUtls/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreGraphics', 'SystemConfiguration', 'CFNetwork', 'CoreTelephony', 'Security', 'QuartzCore', 'Foundation'
  s.libraries = 'z','sqlite3','c++'


  s.dependency 'AFNetworking', '~> 2.5.1'
  s.dependency 'FMDB', '~> 2.5'
  s.dependency 'JSONKit-NoWarning', '~> 1.2'
  s.dependency 'MD5Digest', '~> 0.1.0'
  s.dependency 'OHHTTPStubs', '~> 3.1.8'
  s.dependency 'OpenUDID', '~> 1.0.0'
  s.dependency 'Reachability', '~> 3.2'
  s.dependency 'RegexKitLite', '~> 4.0'
  s.dependency 'UICKeyChainStore', '~> 2.0.4'

end
