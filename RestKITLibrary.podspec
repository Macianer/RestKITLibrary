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
s.license          = 'MIT'
s.author           = { "ronnymeissner" => "developer@meissner-ronny.de" }
s.source           = { :git => "https://github.com/ronnymeissner/RestKITLibrary.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/the_macianer'
s.ios.deployment_target = '5.1.1'
s.osx.deployment_target = '10.7'
s.requires_arc = true

s.dependency 'RestKit', '~> 0.24.0'
s.dependency 'RestKit/Testing', '~> 0.24.0'

s.subspec 'Base' do |bs|
bs.public_header_files = 'Pod/Classes/*.h'
bs.source_files = 'Pod/Classes/*.{h,m}'
end

s.subspec 'UI' do |uis|
uis.public_header_files = 'Pod/Classes/UI/*.h'
uis.source_files = 'Pod/Classes/UI/*.{h,m}'
uis.resources = 'Pod/Assets/UI/*.xib'
end

s.subspec 'GoogleGeocodingAPI' do |ggas|
ggas.dependency 'RestKITLibrary/Base'
ggas.public_header_files = 'Pod/Classes/GoogleGeocodingAPI/*.h'
ggas.source_files = 'Pod/Classes/GoogleGeocodingAPI/*.{h,m}'
end

s.subspec 'GooglePlaceAutocompleteAPI' do |ggas|
ggas.dependency 'RestKITLibrary/Base'
ggas.public_header_files = 'Pod/Classes/GooglePlaceAutocompleteAPI/*.h'
ggas.source_files = 'Pod/Classes/GooglePlaceAutocompleteAPI/*.{h,m}'
end

s.subspec 'RedmineAPI' do |rms|
rms.dependency 'RestKITLibrary/Base'
rms.public_header_files = 'Pod/Classes/RedmineAPI/*.h'
rms.source_files = 'Pod/Classes/RedmineAPI/*.{h,m}'
end

end
