# -*- encoding: utf-8 -*-
# stub: sorcery 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sorcery".freeze
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Noam Ben Ari".freeze, "Kir Shatrov".freeze, "Grzegorz Witek".freeze]
  s.date = "2015-04-05"
  s.description = "Provides common authentication needs such as signing in/out, activating by email and resetting password.".freeze
  s.email = "nbenari@gmail.com".freeze
  s.homepage = "http://github.com/NoamB/sorcery".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.6".freeze
  s.summary = "Magical authentication for Rails 3 & 4 applications".freeze

  s.installed_by_version = "2.6.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0.4.4", "~> 0.4"])
      s.add_runtime_dependency(%q<oauth2>.freeze, [">= 0.8.0"])
      s.add_runtime_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<abstract>.freeze, [">= 1.0.0"])
      s.add_development_dependency(%q<json>.freeze, [">= 1.7.7"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.6.0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0.3.8"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.0.0"])
    else
      s.add_dependency(%q<oauth>.freeze, [">= 0.4.4", "~> 0.4"])
      s.add_dependency(%q<oauth2>.freeze, [">= 0.8.0"])
      s.add_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
      s.add_dependency(%q<abstract>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<json>.freeze, [">= 1.7.7"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.6.0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0.3.8"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0.0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.0.0"])
    end
  else
    s.add_dependency(%q<oauth>.freeze, [">= 0.4.4", "~> 0.4"])
    s.add_dependency(%q<oauth2>.freeze, [">= 0.8.0"])
    s.add_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
    s.add_dependency(%q<abstract>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<json>.freeze, [">= 1.7.7"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.3.8"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.0.0"])
  end
end
