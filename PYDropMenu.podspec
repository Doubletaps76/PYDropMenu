Pod::Spec.new do |s|
  s.name         = 'PYDropMenu'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE'}
  s.homepage     = 'https://github.com/Doubletaps76/PYDropMenu'
  s.authors      = { 'Tsau,Po-Yuan' => 'heineken00000@gmail.com' }
  s.summary      = 'PYDropMenu is an easy-to-use menu library for IOS.'
  s.source       = { :git => 'https://github.com/Doubletaps76/PYDropMenu.git', 
  					 :tag => s.version.to_s }
  s.source_files = 'PYDropMenu/**/*.{h,m}'
  s.platform = :ios, '7.0'
  s.ios.deployment_target = '7.0'
end