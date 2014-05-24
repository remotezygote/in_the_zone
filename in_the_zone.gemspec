# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'in_the_zone/version'

Gem::Specification.new do |spec|
  spec.name          = "in-the-zone"
  spec.version       = InTheZone::VERSION
  spec.authors       = ["John Bragg"]
  spec.email         = ["remotezygote@gmail.com"]
  spec.summary       = %q{Display dates and times reliably in the user's local time zone.}
  spec.description   = %q{This is a simple gem that uses some simple tag generation helpers and some in-page javascript to make sure times displayed in a page are in the browser's local time zone and format.}
  spec.homepage      = "https://github.com/remotezygote/in_the_zone"
  spec.license       = "MIT"

  cert = File.expand_path("~/.ssh/gem-private_key_remotezygote.pem")
  if File.exist?(cert)
    spec.signing_key = cert
    spec.cert_chain = ["gem-public_cert.pem"]
  end

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"

  spec.add_dependency 'erubis'
end
