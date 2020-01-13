#
# Be sure to run `pod lib lint WRSwiftKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WRSwiftKit'
  s.version          = '0.0.1'
  s.summary          = '常用 Swift 工具类定义.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '常用 Swift 方法、扩展、分类,便于初始化项目'

  s.homepage         = 'https://github.com/Godfighter/WRSwiftKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Godfighter' => 'xianghui_ios@163.com' }
  s.source           = { :git => 'https://github.com/Godfighter/WRSwiftKit.git', :tag => s.version.to_s }
  s.frameworks   = 'UIKit','Foundation'
  s.social_media_url = 'http://weibo.com/huigedang/home?wvr=5&lf=reg'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  #s.subspec 'Device' do |ss|
  #  ss.source_files = 'Source/Device/*.swift'
  #end
  
  
  
  # s.resource_bundles = {
  #   'WRSwiftKit' => ['WRSwiftKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
