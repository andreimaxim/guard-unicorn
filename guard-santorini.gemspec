# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard-santorini/version"

Gem::Specification.new do |s|
  s.name        = "guard-santorini"
  s.version     = Guard::Santorini::VERSION
  s.authors     = ["Andrei Maxim"]
  s.email       = ["andrei@andreimaxim.ro"]
  s.homepage    = "https://github.com/xhr/guard-santorini"
  s.summary     = "Guard for running Rails tests"
  s.description = "Guard plug-in that allows you to run Rails tests automatically"

  s.rubyforge_project = "guard-santorini"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
