# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "guard-unicorn"
  s.version     = "0.0.7"
  s.authors     = ["Andrei Maxim"]
  s.email       = ["andrei@andreimaxim.ro"]
  s.homepage    = "https://github.com/xhr/guard-unicorn"
  s.summary     = "Guard for Unicorn"
  s.description = "Guard plug-in that allows you to restart Unicorn"

  s.rubyforge_project = "guard-unicorn"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "guard", ">= 1.1"

  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest"
  s.add_development_dependency "guard"
end
