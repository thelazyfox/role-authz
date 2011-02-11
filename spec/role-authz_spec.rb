require File.expand_path('../spec_helper', __FILE__)

describe "ObjectMixin" do
  describe ".authorizable!" do
    it "includes OperatorMixin" do      
      class Foo
        authorizable!
      end
    
      Foo.ancestors.should include(::Authorization::OperatorMixin)
    end
  end
end

