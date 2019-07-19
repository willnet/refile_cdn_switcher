lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "refile_cdn_switcher/version"

Gem::Specification.new do |spec|
  spec.name          = "refile_cdn_switcher"
  spec.version       = RefileCdnSwitcher::VERSION
  spec.authors       = ["willnet"]
  spec.email         = ["netwillnet@gmail.com"]

  spec.summary       = %q{a Refile extention to disable cdn as default}
  spec.description   = %q{a Refile extention to disable cdn as default}
  spec.homepage      = "https://github.com/willnet/refile_cdn_switcher"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "refile", ">= 0.6.2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "< 1.4.0"
end
