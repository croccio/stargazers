# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Stargazers' do
  use_frameworks!

  # Pods for Stargazers
  
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'RxBiBinding', '0.3.5'
  pod 'RxBinding', '0.5'
  pod 'ReactiveCocoa', '11.2.1'
  pod 'TPKeyboardAvoiding', '1.3.5'
  
  # Local Pods
  pod 'github-service', :path => './LocalPods/github-service', :testspecs => ['Tests']
  pod 'MVP', :path => './LocalPods/MVP'

  target 'StargazersTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '6.2.0'
    pod 'RxTest', '6.2.0'
  end

  target 'StargazersUITests' do
    # Pods for testing
  end

end
