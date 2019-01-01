Pod::Spec.new do |s|
  s.name          = 'ReWebkit'
  s.version       = '0.1.1'
  s.summary       = 'A simple webkit combined with RxSwift'
  s.homepage      = 'https://github.com/jiwonsis/ReWebkit'
  s.summary       = 'A simple webkit combined with RxSwift'  
  s.author        = { 'Scott Moon' => 'interactord@gmail.com' }
  s.source        = { :git => 'https://github.com/jiwonsis/ReWebkit.git',
                      :tag => s.version.to_s }
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.source_files  = 'Sources/ReWebKit/**/*'
  s.frameworks    = 'UIKit', 'Foundation'
  s.requires_arc  = true

  s.dependency 'RxSwift', '>= 4.4.0'
  s.dependency 'RxCocoa', '>= 4.4.0'

  s.ios.deployment_target = '11.0'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.2'
  }
end