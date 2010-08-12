begin
  # Just in case the bundle was locked
  # This shouldn't happen in a dev environment but lets be safe
  require '.bundle/environment'
rescue LoadError
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end
require 'rake/gempackagetask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "role-authz"
GEM_VERSION = "0.0.1"
AUTHOR = "Jorge Villatoro"
EMAIL = "jorge@tomatocannon.com"
HOMEPAGE = "http://www.github.com/thelazyfox/role-authz"
SUMMARY = "A merb plugin that provides simple role based authorization"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-core', '>= 1.1.3')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec}/**/*")
  
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

begin
  require 'spec'
  require 'spec/rake/spectask'

  task :default => [ :spec ]

  desc 'Run specifications'
  Spec::Rake::SpecTask.new(:spec) do |t|
    t.spec_opts << '--options' << 'spec/spec.opts' if File.exists?('spec/spec.opts')
    t.spec_opts << '--color' << '--format' << 'specdoc'
    begin
      require 'rcov'
      t.rcov_opts << '--exclude' << 'spec'
      t.rcov_opts << '--text-summary'
      t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
    rescue LoadError
      # rcov not installed
    end
  end
rescue LoadError
  # rspec not installed
end
