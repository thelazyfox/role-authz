require File.expand_path('../spec_helper', __FILE__)

describe "ControllerMixin" do
  describe ".role(name, &block)" do
    it "defines roles the the specified name and block"
    it "raises an exception when the block does not accept 2 arguments"
  end
  describe ".authorize(target, &block)" do
    it "sets the permissions on the target that are specified by the block"
    it "sets self as the authorization proxy on the target"
    it "enforces #ensure_authorized as a before filter"
  end
  
  describe "#ensure_authorized" do
    it "raises the Unauthenticated exception when unauthenticated"
    it "raises the Unauthorized exception when no permissions match"
  end
end

describe "ControllerHelper" do
  describe "#for_roles(*the_roles)" do
    it "selects roles for which to define permissions"
    it "raises an exception when called directly after #for_roles"
    it "has the alias #for_role"
  end
  describe "#allow(*the_actions)" do
    it "sets permissions to be set for the specified roles"
    it "raises an exception when not called directly after #for_roles"
  end
  describe "#actions_for(role)" do
    it "returns the previously set actions for the specified role"
  end
end