#
# Be sure to run `pod lib lint CUU.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CUU'
  s.version          = '1.1.0'
  s.summary          = 'CUU is a framework to help analyzing th usage of your applications.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CUU is a project to help analyzing the usage of your app by providing functionality to track user interactions within your app. This data can then be used to track usage of your features.
                       DESC

  s.homepage         = 'https://cuu.ase.in.tum.de'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Lara Marie Reimer', 'Jan Philip Bernius', 'Jan Ole Johanßen'
  s.source           = { :git => 'https://github.com/cures-hub/cures-cuu-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/ls1intum'

  s.ios.deployment_target = '11.0'

  s.source_files = 'CUU/Classes/**/*.{swift,xcdatamodeld,mlmodel}'
  s.resources = 'CUU/Classes/InteractionKit/Core/CoreData/IKData.xcdatamodeld'
  s.swift_version = "4.0"
  
  s.preserve_paths = 'CUU/Classes/InteractionKit/Core/CoreData/IKData.xcdatamodeld','CUU/Classes/BehaviorKit/Models/*/*.mlmodel'
  
  s.resource_bundles = {
  'CUU' => ['CUU/Assets/*']
  }

end
