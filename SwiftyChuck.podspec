#
# Be sure to run `pod lib lint SwiftyChuck.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyChuck'
  s.version          = '1.2.5'
  s.summary          = 'Chuck is in-app HTTP inspector for iOS OkHttp clients.'
  s.swift_versions   = '5'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Chuck is in-app HTTP inspector for iOS OkHttp clients. Chuck intercepts and persists all HTTP requests and responses inside your application, and provides a UI for inspecting their content."

  s.homepage         = 'https://github.com/MacKevinCE/SwiftyChuck'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mac Kevin C. E.' => 'mac.kevin.c.e@gmail.com' }
  s.source           = { :git => 'https://github.com/MacKevinCE/SwiftyChuck.git', :tag => s.version.to_s }
  s.documentation_url= 'https://github.com/MacKevinCE/SwiftyChuck'
  s.social_media_url = 'https://twitter.com/MacKevinCE'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SwiftyChuck/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftyChuck' => ['SwiftyChuck/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
