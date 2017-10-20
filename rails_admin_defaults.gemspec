$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_defaults/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_defaults"
  s.version     = RailsAdminDefaults::VERSION
  s.authors     = ["SarCasm"]
  s.email       = ["sarcasm008@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsAdminDefaults."
  s.description = "TODO: Description of RailsAdminDefaults."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.1.2"
  s.add_dependency 'rails_admin', '~> 1.2'

  s.add_development_dependency "sqlite3"
end
