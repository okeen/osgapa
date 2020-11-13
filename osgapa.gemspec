Gem::Specification.new do |s|
  s.name      = 'osgapa'
  s.version   = '0.0.1'
  s.platform  = Gem::Platform::RUBY
  s.summary   = 'Log extraction and sorting gem'
  s.description = "Homework for Thursday night"
  s.authors   = ['Eneko Taberna']
  s.email     = ['eneko.taberna@gmail.com']
  s.homepage  = 'http://rubygems.org/gems/osgapa'
  s.license   = 'MIT'
  s.files     = Dir.glob("{lib,bin}/**/*") # This includes all files under the lib directory recursively, so we don't have to add each one individually.
  s.require_path = 'lib'
  s.executables = ['osgapa']
end
