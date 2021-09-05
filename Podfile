# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Stargazers' do
  use_frameworks!

  # Pods for Stargazers
  
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  
  # Local Pods
  pod 'github-service', :path => './LocalPods/github-service', :testspecs => ['Tests'] 

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
