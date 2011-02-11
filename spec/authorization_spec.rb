require File.expand_path('../spec_helper', __FILE__)

describe "Authorization" do
  before :each do
    Authorization.clear!
  end
  
  describe ".add_role(name, &block)" do
    it "accepts valid roles" do
      Authorization.should respond_to(:add_role)
      lambda do 
        Authorization.add_role(:foo) do |operator, target|
          if operator == "jorge"
            true
          else
            false
          end
        end
      end.should_not raise_error
    end
    
    it "raises InvalidRole exception when the role block is invalid" do
      lambda do
        Authorization.add_role(:foo) {|operator| true}
      end.should raise_error
    end
  end
  
  describe ".roles_for(operator, target)" do
    it "returns correct roles for operator, target pairs" do
      Authorization.add_role(:foo) do |operator, target|
        if operator == "foo"
          true
        else
          false
        end
      end
      Authorization.add_role(:bar) do |operator, target|
        if operator == "bar"
          true
        else
          false
        end
      end
      
      Authorization.roles_for("foo",nil).should == [:foo]
      Authorization.roles_for("bar",nil).should == [:bar]
    end
  end
end
