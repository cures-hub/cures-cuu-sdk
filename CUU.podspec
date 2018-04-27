#
# Be sure to run `pod lib lint CUU.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CUU'
  s.version          = '1.0.0'
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
  s.authors           = 'Lara Marie Reimer', 'Jan Philip Bernius', 'Jan Ole Johanßen'
  s.source           = { :git => 'https://github.com/cures-hub/cures-cuu-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/ls1intum'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CUU/Classes/**/*'
  s.swift_version = "4.0"
  
#s.resource_bundles = {
#  'CUU' => ['CUU/Assets/*.png']
#  }

  # --- Subspecs --- #

    s.subspec 'CUUCore' do |cuucore|
    cuucore.source_files = 'CUU/Classes/CUUCore/**/*'
    end

  s.subspec 'FeatureKit' do |featurekit|
    featurekit.source_files = 'CUU/Classes/FeatureKit/**/*'
    featurekit.dependency 'CUU/CUUCore'
  end

  s.subspec 'InteractionKit' do |interactionkit|
    interactionkit.source_files = 'CUU/Classes/InteractionKit/**/*'
    interactionkit.dependency 'CUU/CUUCore'
  end

end
