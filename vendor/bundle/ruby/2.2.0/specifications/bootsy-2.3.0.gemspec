# -*- encoding: utf-8 -*-
# stub: bootsy 2.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bootsy"
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Volmer Soares"]
  s.date = "2016-06-08"
  s.description = "A beautiful WYSIWYG editor with image uploads for Rails."
  s.email = ["rubygems@radicaos.com"]
  s.homepage = "http://github.com/volmer/bootsy"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "A beautiful WYSIWYG editor with image uploads for Rails."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>, ["~> 4.5"])
      s.add_runtime_dependency(%q<carrierwave>, ["~> 0.11"])
    else
      s.add_dependency(%q<mini_magick>, ["~> 4.5"])
      s.add_dependency(%q<carrierwave>, ["~> 0.11"])
    end
  else
    s.add_dependency(%q<mini_magick>, ["~> 4.5"])
    s.add_dependency(%q<carrierwave>, ["~> 0.11"])
  end
end
