#
# Be sure to run `pod lib lint DLUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DLUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LiYang/DLUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiYang' => '308689786@qq.com' }
  s.source           = { :git => 'https://github.com/LiYang/DLUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'DLUIKit/Classes/**/*'
  
  s.resource_bundles = {
    'DLUIKit' => ['DLUIKit/Assets/*.png']
  }

  s.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore', 'Foundation', 'CoreText', 'CoreGraphics', 'WebKit'

  s.dependency 'Masonry', '~> 0.6.0'
  s.dependency 'ReactiveCocoa', '~> 2.3.1'

end
