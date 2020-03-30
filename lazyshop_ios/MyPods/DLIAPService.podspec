#
# Be sure to run `pod lib lint BaseWithRAC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLIAPService'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BaseWithRAC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LiYang/BaseWithRAC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiYang' => '308689786@qq.com' }
  s.source           = { :git => 'https://github.com/LiYang/BaseWithRAC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'DLIAPService/Classes/**/*'
  
  s.resource_bundles = {
    'DLIAPService' => ['DLIAPService/Assets/*.png']
  }

  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/../MyPods/DLIAPService/Classes' }

  s.libraries = 'z', 'stdc++', 'sqlite3.0'

  s.ios.vendored_frameworks = 'DLIAPService/Lib/*.framework'
  s.ios.vendored_libraries = 'DLIAPService/Lib/*.a'

  s.frameworks = 'UIKit', 'StoreKit', 'CoreMotion', 'CFNetwork', 'SystemConfiguration'

  s.dependency 'LinqToObjectiveC', '~> 2.0.0'
  s.dependency 'MD5Digest', '~> 0.1.0'
  s.dependency 'Mantle', '~> 1.5.4'
  s.dependency 'Masonry', '~> 0.6.0'
  s.dependency 'ReactiveCocoa', '~> 2.3.1'
  s.dependency 'ReactiveViewModel', '~> 0.2'

end
