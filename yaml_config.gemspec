# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'yaml_config/version'

spec = Gem::Specification.new do |s|
  s.authors           = ["Dima Lunich"]
  s.email             = ["dima.lunich@gmail.com"]
  s.date              = "2011-03-29"
  s.homepage          = "http://github.com/lunich/yaml_config"
  s.rubyforge_project = ""
  s.name              = YamlConfigHelper::GEM_NAME
  s.version           = YamlConfigHelper::VERSION
  s.summary           = "#{YamlConfigHelper::GEM_NAME}-#{YamlConfigHelper::VERSION}"
  s.description       = "This gem reads and manage YAML config files"
  s.files             = Dir.glob("{lib,spec}/**/*") + ["README.rdoc", "Changelog", "Gemfile", "init.rb"]
  s.test_files        = Dir.glob("spec/**/*")
  s.require_path      = "lib"
  s.extra_rdoc_files  = ["README.rdoc"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.add_development_dependency "rspec"
end
