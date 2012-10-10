# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'producer_consumer/version'

Gem::Specification.new do |gem|
  gem.name          = "axle-producer_consumer"
  gem.version       = ProducerConsumer::VERSION
  gem.authors       = ["Alex Gibbons"]
  gem.email         = ["alex.gibbons@gmail.com"]
  gem.description   = %q{Threaded producer/consumer model. Useful when you have an expensive data producer, such as fetching data over many http connections, and an expensive consumer, such as ingesting into a database.}
  gem.summary       = %q{Simple producer/consumer model.}
  gem.homepage      = "https://github.com/alexgb/producer_consumer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", "~> 2.6"
end
