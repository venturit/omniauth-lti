# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-lti/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-lti"
  s.version     = Omniauth::Lti::VERSION
  s.authors     = ["Xavi Aracil"]
  s.email       = ["xavi@laibeth.com"]
  s.homepage    = "https://github.com/xaviaracil/omniauth-lti"
  s.summary     = %q{OmniAuth strategy for LTI spec}
  s.description = %q{OmniAuth strategy for providing LTI authentication to an OmniAuth application}

  s.rubyforge_project = "omniauth-lti"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  #s.add_dependency 'omniauth'
  #s.add_dependency 'ims-lti'
end
