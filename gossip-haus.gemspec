lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "gossip-haus"
  s.version     = "1.0.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Oestrich"]
  s.email       = ["eric@oestrich.org"]
  s.summary     = "Client for the Gossip Chat Network"
  s.description = "Ruby client to connect to the Gossip Chat Network"
  s.homepage    = "http://github.com/oestrich/gossip-ruby"
  s.license     = "MIT"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "faye-websocket", "~> 0.10"
  s.add_runtime_dependency "eventmachine", "~> 1.2"

  s.files        = Dir.glob("lib/**/*")
  s.require_path = "lib"
end
