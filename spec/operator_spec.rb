require File.expand_path('../spec_helper', __FILE__)

describe "OperatorMixin" do
  describe "#authorized?(args)" do
    before do
      Authorization.clear!
      @user = Class.new
      @user.instance_eval {authorizable!}
      @admin = @user.clone
      @controller = Class.new Merb::Controller
      @controller.role(:admin) {|operator,target|operator.kind_of?(@admin)}
      @controller.role(:user) {|operator,target|operator.kind_of?(@user)}
      @controller.role(:owner) {|operator,target|target.respond_to?(:owner)&&target.owner==operator}
      @controller.authorize(@controller) do
        for_role(:admin).allow(:foo)
        for_role(:user).allow(:bar)
      end
      
    end
    
    it "returns true when the requested role matches" do
      @admin.new.authorized?(:role=>:admin).should be_true
      @user.new.authorized?(:role=>:user).should be_true
    end
    
    it "returns false when the requested role does not match" do
      @admin.new.authorized?(:role=>:user).should be_false
      @user.new.authorized?(:role=>:admin).should be_false
    end
    
    it "returns false when only an action is specified" do
      @admin.new.authorized?(:action=>:bar).should be_false
      @admin.new.authorized?(:action=>:foo).should be_false
    end
    
    it "returns true when the requested target+action matches" do
      user = @user.new
      resource = Class.new
      resource.stub!(:owner).and_return(user)
      @controller.clone.authorize(resource) {for_role(:owner).allow(:foo)}
      
      user.authorized?(:target=>resource,:action=>:foo).should be_true
    end
    
    it "returns false when the requested target+action does not match" do
      user = @user.new
      resource = Class.new
      resource.stub!(:owner).and_return(user.clone)
      @controller.clone.authorize(resource) {for_role(:owner).allow(:foo)}
      
      user.authorized?(:target=>resource,:action=>:foo).should be_false
    end
    
  end
  
  describe "#roles_for" do
    it "returns the roles for self on the specified target" do
      @user = Class.new
      @user.instance_eval {authorizable!}
      user = @user.new
      
      resource = Class.new
      resource.stub!(:owner).and_return(user)
      Authorization.add_role(:user){|operator,target|operator.kind_of?(@user)}
      Authorization.add_role(:owner){|operator,target|target.respond_to?(:owner)&&target.owner==operator}
      
      user.roles_for(resource).should include(:owner)
      user.clone.roles_for(resource).should_not include(:owner)
    end
  end
end
