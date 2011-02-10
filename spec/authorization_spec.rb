require File.expand_path('../spec_helper', __FILE__)

describe "Authorization" do
  describe ".add_role(name, &block)" do
    it "accepts valid roles"
    it "raises InvalidRole exception when the role block is invalid"
  end
  describe ".roles_for(operator, target)" do
    it "returns correct roles for operator, target pairs"
  end
end
