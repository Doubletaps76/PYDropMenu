Pod::Spec.new do |spec|
  spec.name         = 'PYDropMenu'
  spec.version      = '0.1'
  spec.license      = { :type => 'MIT' , :file => 'License'}
  spec.homepage     = 'https://github.com/Doubletaps76/PYDropMenu'
  spec.authors      = { 'Tsau,Po-Yuan' => 'heineken00000@gmail.com' }
  spec.summary      = 'A easy use dropmenu library for IOS.'
  spec.source       = { :git => 'https://github.com/Doubletaps76/PYDropMenu.git', :tag => 'v0.1' }
  spec.source_files = '/PYDropMenu/**/*.{h,m}'
  spec.requires_arc = ture
  spec.platform = :ios, '7.0'
  spec.ios.deployment_target = '7.0'
end