Pod::Spec.new do |s|
  s.name = 'MDKeychain'
  s.version = '0.1'
  s.license = 'Proprietary'
  s.summary = 'Simple wrapper around the iOS Keychain.'
  s.description = "This treats the iOS keychain as a simple KV store, similar to a dictionary. This even supports using the square bracket '[]' operator."
  s.homepage = 'https://stash.mgmt.local/projects/IOSLIB/repos/mdkeychain'
  s.authors = { 'Michael Leber' => 'michael.leber@ihsmarkit.com'}
  s.source = { :git => 'ssh://git@stash.mgmt.local/ioslib/mdkeychain.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.swift'
  # s.resource_bundles = {
  #   'MDKeychain' => ['Resources/*']
  # }

  # add dependencies when needed  
  # s.dependency 'CSV.swift', '~> 1.0'
  # s.dependency 'MD-Extensions'
end
