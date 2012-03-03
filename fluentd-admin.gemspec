# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join('..', 'lib'), __FILE__)

require 'fluent/admin/version'

Gem::Specification.new do |gem|
  gem.name        = "fluentd-admin"
  gem.description = "Administration interface for Fluentd"
  gem.homepage    = "https://github.com/repeatedly/fluentd-admin"
  gem.summary     = gem.description
  gem.version     = Fluent::Admin.version
  gem.authors     = ["Masahiro Nakagawa"]
  gem.email       = "repeatedly@gmail.com"
  gem.has_rdoc    = false
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "sinatra", ">= 1.3.2"
  gem.add_development_dependency "rake", ">= 0.9.2"
  gem.add_development_dependency "simplecov", ">= 0.5.4"
  gem.add_development_dependency "rr", ">= 1.0.0"
end
