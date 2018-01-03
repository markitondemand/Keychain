Pod::Spec.new do |s|
  s.name = 'MDKeychain'
  s.version = '0.2'
  s.license = 'MIT'
  s.summary = 'Simple wrapper around the iOS Keychain.'
  s.description = "This treats the iOS keychain as a simple KV store, similar to a dictionary. This even supports using the square bracket '[]' operator."
  s.homepage = 'https://github.com/markitondemand/iOS-Keychain'
  s.authors = { 'Michael Leber' => 'michael.leber@ihsmarkit.com'}
  s.source = { :git => 'https://github.com/markitondemand/iOS-Keychain.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.swift'
  # s.resource_bundles = {
  #   'MDKeychain' => ['Resources/*']
  # }
end
