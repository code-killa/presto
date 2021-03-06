$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "presto/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "presto"
  s.version     = Presto::VERSION
  s.authors     = ["Luisk Hernandez, Luis Rodriguez"]
  s.email       = ["luisk.hernandez.macias@gmail.com, ljrzarate@gmail.com"]
  s.homepage    = "http://luiskhernandez.com"
  s.summary     = "Gem that override welcome page"
  s.description = "Gem that override welcome page"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "formtastic", "~> 3.0"
  s.add_dependency "formtastic-bootstrap"
  s.add_dependency "will_paginate"
  s.add_dependency "will_paginate-bootstrap"
  s.add_dependency "jquery-rails"
  s.add_dependency "turbolinks"
  s.add_dependency "haml"
  s.add_dependency "ransack"

  s.add_development_dependency "sqlite3"
end
