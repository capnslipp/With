Pod::Spec.new do |s|
  s.name = 'With'
  s.version = ->{
    Dir.chdir(__dir__) do
      semver_regex = /\d+\.\d+\.\d+(?:-[\w\.]+)?(?:\+[\w\.]+)?/
      return `xcodebuild -showBuildSettings 2>/dev/null`.match(/CURRENT_PROJECT_VERSION = (#{semver_regex})/)[1]
    end
  }.call
  s.swift_versions = ['5.0']
  s.authors = { 'capnslipp' => 'With@capnslipp.com' }
  s.social_media_url = 'https://twitter.com/capnslipp'
  s.license = { :type => 'Public Domain', :file => 'LICENSE' }
  s.homepage = 'https://github.com/capnslipp/With'
  s.source = { :git => 'https://github.com/capnslipp/With.git', :tag => "podspec/#{s.version}" }
  s.summary = "A Swift µ-Library Providing a with(…) { … } Statement"
  s.description = "With is a Swift micro-library that provides a `with` statement, similar to what's built into Python, JavaScript, Visual Basic, Object Pascal, Delphi, C#, & Kotlin."
  
  # Platform
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  
  # File Patterns
  s.source_files = 'Sources/**/*'
end
