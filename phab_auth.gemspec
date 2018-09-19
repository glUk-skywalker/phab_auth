$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'phab_auth/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'phab_auth'
  s.version     = PhabAuth::VERSION
  s.authors     = ['Oleg Ivanov']
  s.email       = ['gluk.main+github@gmail.com', 'ivanov@megaputer.ru']
  s.homepage    = ''
  s.summary     = 'The plugin simplifies authentication via phabricator'
  s.description = ''
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1'
end
