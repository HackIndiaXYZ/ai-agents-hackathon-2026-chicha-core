Pod::Spec.new do |s|
  s.name             = 'ct2_bridge'
  s.version          = '1.0.0'
  s.summary          = 'CTranslate2 Dart FFI bridge for iOS.'
  s.description      = 'Exposes on-device machine translation APIs using CTranslate2 and SentencePiece.'
  s.homepage         = 'https://bhashalens.example.com'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'BhashaLens Team' => 'team@bhashalens.example.com' }
  s.source           = { :path => '.' }
  
  s.ios.deployment_target = '12.0'
  s.source_files = 'src/**/*.{h,cpp}'
  s.public_header_files = 'src/**/*.h'
  
  # Tell Cocoapods that the headers should be preserved and accessible
  s.xcconfig = { 'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17' }
end
