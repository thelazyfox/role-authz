require File.expand_path('../spec_helper', __FILE__)

describe "Object Mixin" do
  it "includes OperatorMixin with #authorizable!"
  it "includes ResourceMixin with #authorize!"
end

describe "Operator Mixin" do
  it "responds to #authorized?"
  it "responds to #roles_for"
end
