# make sure we're running inside Merb
if defined?(Merb::Plugins)

  require 'merb-auth-core'
  path = File.dirname(__FILE__)
  Dir[path / "role-authz" / "authorization" / "**/*.rb"].each do |f|
    require f
  end
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
end