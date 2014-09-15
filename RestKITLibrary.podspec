#
# Be sure to run `pod lib lint RestKITLibrary.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RestKITLibrary"
  s.version          = "0.1.2"
  s.summary          = "RestKITLibrary represent a library for Restful webservices based on RestKit."
  s.description      = <<-DESC
                       An optional longer descripth

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/ronnymeissner/RestKITLibrary"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "ronnymeissner" => "owner@meissner-ronny.de" }
  s.source           = { :git => "https://github.com/ronnymeissner/RestKITLibrary.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/the_macianer'
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true
#s.resources = 'Pod/Assets/*.png'

  s.dependency 'RestKit', '~> 0.23.3'
  s.dependency 'RestKit/Testing', '~> 0.23.3'
  s.subspec 'Base' do |bs|
    bs.public_header_files = 'Pod/Classes/*.h'
    bs.source_files = 'Pod/Classes/*.{h,m}'
  end
  
  s.subspec 'GoogleGeocodingAPI' do |ggas|
    ggas.dependency 'RestKITLibrary/Base'
    ggas.public_header_files = 'Pod/Classes/GoogleGeocodingAPI/*.h'
    ggas.source_files = 'Pod/Classes/GoogleGeocodingAPI/*.{h,m}'
  end
  
  s.subspec 'GooglePlacesAPI' do |ggas|
    ggas.dependency 'RestKITLibrary/Base'
    ggas.public_header_files = 'Pod/Classes/GooglePlacesAPI/*.h'
    ggas.source_files = 'Pod/Classes/GooglePlacesAPI/*.{h,m}'
  end

end
