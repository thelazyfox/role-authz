# Loads up Merb and the Plugin
require 'merb-core'
require 'spec'
require File.expand_path("../../lib/role-authz", __FILE__)

# Simple helper to clear out the auth role list
module Authorization
  def self.clear!
    @roles.clear
  end
end