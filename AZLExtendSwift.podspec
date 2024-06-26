#
# Be sure to run `pod lib lint AZLExtendSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AZLExtendSwift'
  s.version          = '0.4.6'
  s.summary          = '常用扩展'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/azusalee/AZLExtend'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'azusalee' => '384433472@qq.com' }
  s.source           = { :git => 'https://github.com/azusalee/AZLExtend.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  #s.source_files = 'AZLExtendSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AZLExtend' => ['AZLExtend/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s.frameworks = 'UIKit', 'Accelerate'
  #s.libraries = 'CommonCrypto'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.default_subspecs = 'Core', 'UI'
  
  
  s.subspec 'Core' do |core|
    core.source_files = 'AZLExtendSwift/Classes/Core/**/*'
  end

  s.subspec 'UI' do |ui|
    ui.source_files = 'AZLExtendSwift/Classes/UI/**/*'
    ui.dependency "AZLExtendSwift/Core"
  end
  
end
