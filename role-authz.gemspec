# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{role-authz}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jorge Villatoro"]
  s.date = %q{2009-02-18}
  s.description = %q{Merb plugin that provides a very simple role-based authorization system}
  s.email = %q{programmerjorge@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/role-authz", "lib/role-authz/authorization", "lib/role-authz/authorization/authorization.rb", "lib/role-authz/authorization/controller_helper.rb", "lib/role-authz/authorization/controller_mixin.rb", "lib/role-authz/authorization/object_mixin.rb", "lib/role-authz/authorization/operator_mixin.rb", "lib/role-authz.rb", "spec/role-authz_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb plugin that provides a very simple role-based authorization system}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb>, [">= 1.0.9"])
    else
      s.add_dependency(%q<merb>, [">= 1.0.9"])
    end
  else
    s.add_dependency(%q<merb>, [">= 1.0.9"])
  end
end
