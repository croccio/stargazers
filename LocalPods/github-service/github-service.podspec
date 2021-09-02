#
# Be sure to run `pod lib lint stargazers-service.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'github-service'
  s.version          = '0.1.0'
  s.summary          = 'Github api'


s.description      = <<-DESC
Stargazer rest api
                       DESC

  s.homepage         = 'https://github.com/croccio/stargazers-service'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'croccio' => 'antonio.scardigno@finconsgroup.com' }
  s.source           = { :git => 'https://github.com/croccio/stargazers-service.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'github-service/**/*'

  s.dependency 'RxSwift', '6.2.0'
  s.dependency 'RxCocoa', '6.2.0'
  s.dependency 'RealmSwift', '10.12.0'

end
