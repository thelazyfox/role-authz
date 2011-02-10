require File.expand_path('../spec_helper', __FILE__)

describe "ResourceMixin" do
  describe ".authorize" do
  end
end
  
describe "ResourceHelper" do
  describe "#for_roles(*the_roles)" do
    it "selects the roles for which to define permissions"
    it "raises an exception when followed directly by another #for_role"
    it "has the alias #for_role"
  end
  
  describe "#create(*the_properties)" do
    it "sets which properties can be set on creation by the specified roles"
    it "raises an exception if it does not directly follow #for_roles"
  end
  
  describe "#modify(*the_properties)" do
    it "sets which properties can be modified by the specified roles"
    it "raises an exception if it does not directly follow #for_roles"
  end
  
  describe "#creatable_by(*the_roles)" do
    it "returns the creatable properties by the specified roles"
  end
  
  describe "#modifiable_by(*the_roles)" do
    it "returns the modifiable properties by the specified roles"
  end
end