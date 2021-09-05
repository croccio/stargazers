#
# Be sure to run `pod lib lint MVP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MVP'
  s.version          = '0.1.0'
  s.summary          = 'MVP'


s.description      = <<-DESC
Stargazer rest api
                       DESC

  s.homepage         = 'https://github.com/croccio/MVP'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'croccio' => 'antonio.scardigno@finconsgroup.com' }
  s.source           = { :git => 'https://github.com/croccio/MVP.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.5'

  s.source_files = 'MVP/**/*'
  
  #s.test_spec 'Tests' do |test_spec|
  #  test_spec.source_files = 'Tests/**/*.{h,m,swift}'
  #end


end
