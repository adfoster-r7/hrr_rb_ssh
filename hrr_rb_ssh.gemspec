lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hrr_rb_ssh/version"

Gem::Specification.new do |spec|
  spec.name          = "hrr_rb_ssh"
  spec.version       = HrrRbSsh::VERSION
  spec.license       = 'Apache-2.0'
  spec.summary       = %q{Pure Ruby SSH 2.0 server and client implementation}
  spec.description   = %q{Pure Ruby SSH 2.0 server and client implementation}
  spec.authors       = ["hirura"]
  spec.email         = ["hirura@gmail.com"]
  spec.homepage      = "https://github.com/hirura/hrr_rb_ssh"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  # Standard libraries: https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/
  spec.add_runtime_dependency 'base64'

  spec.add_development_dependency "rake", ">= 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
