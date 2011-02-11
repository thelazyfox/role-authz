require File.expand_path('../spec_helper', __FILE__)

describe "ControllerMixin" do
  before :each do
    Authorization.clear!
    @controller = Class.new Merb::Controller
  end
  
  describe ".role(name, &block)" do
    it "defines roles the the specified name and block" do
      lambda do
        @controller.role(:admin) { |operator,target| operator=="admin" }
        @controller.role(:user)  { |operator,target| operator=="user" }
        @controller.role(:owner) { |operator,target| operator==target }
      end.should_not raise_error
      
      Authorization.roles_for("user").should == [:user]
      Authorization.roles_for("admin").should == [:admin]
      Authorization.roles_for("owner","owner").should == [:owner]
      Authorization.roles_for("user","user").should include(:user, :owner)
    end
    
    it "raises an exception when the block does not accept 2 arguments" do
      lambda {@controller.role(:foo) {|operator|}}.should raise_error
    end
  end
  
  describe ".authorize(target, &block)" do
    it "can specify self as the target" do
      @controller.should respond_to(:authorize)
      lambda {@controller.authorize(@controller) {}}.should_not raise_error
    end
    
    it "can sepcify a resource as a target" do
      @resource = Class.new
      
      @controller.should respond_to(:authorize)
      lambda {@controller.authorize(@resource) {}}.should_not raise_error
      @resource.should respond_to(:_authorization_proxy)
      @resource._authorization_proxy.should == @controller
    end
    
    it "enforces #ensure_authorized as a before filter" do
      lambda {@controller.authorize(@controller) {}}.should_not raise_error
      @controller._before_filters.flatten.should include(:ensure_authorized)
    end
  end
  
  describe "#ensure_authorized" do
    it "raises the Unauthenticated exception when unauthenticated" do
      session = mock("session")
      session.stub!(:authenticated?).and_return(false)
      
      controller = @controller.new(nil)
      controller.stub!(:session).and_return(session)
      controller.stub!(:params).and_return({:action => :foo})
      controller.should respond_to(:ensure_authorized)
      lambda do
        controller.ensure_authorized
      end.should raise_exception(Merb::Controller::Unauthenticated)
    end
    
    it "raises the Unauthorized exception when no permissions match" do
      session = mock("session");
      session.stub!(:authenticated?).and_return(true)
      session.stub!(:user).and_return("user")
      
      controller = @controller.new(nil)
      controller.stub!(:session).and_return(session)
      controller.stub!(:params).and_return({:action => :foo})
      controller.should respond_to(:ensure_authorized)
      lambda do
        controller.ensure_authorized
      end.should raise_exception(::Merb::Controller::Unauthorized)
    end
    
    it "raises no exceptions when a permission matches" do
      session = mock("session");
      session.stub!(:authenticated?).and_return(true)
      session.stub!(:user).and_return("user")
      
      @controller.role(:user) {|operator,target|operator=="user"}
      @controller.authorize(@controller) do
        for_role(:user).allow(:foo)
      end
      
      controller = @controller.new(nil)
      controller.stub!(:session).and_return(session)
      controller.stub!(:params).and_return({:action => :foo})
      
      controller.should respond_to(:ensure_authorized)
      lambda {controller.ensure_authorized}.should_not raise_exception
    end
  end
end

describe "ControllerHelper" do
  before :each do
    @authorization = Authorization::ControllerHelper.new
  end
  
  describe "#for_roles(*the_roles)" do
    it "selects roles for which to define permissions" do
      @authorization.instance_eval do
        for_roles(:user).allow(:bar)
      end
      @authorization.actions_for(:user).should include(:bar)
      @authorization.actions_for(:foo).should_not include(:bar)
    end
    
    it "raises an exception when called directly after #for_roles" do
      lambda do
        @authorization.instance_eval do
          for_roles(:user)
          for_roles(:admin)
        end
      end.should raise_error
    end
    
    it "has the alias #for_role" do
      @authorization.should respond_to(:for_role)
    end
  end
  
  describe "#allow(*the_actions)" do
    it "sets permissions to be set for the specified roles" do
      @authorization.instance_eval do
        for_roles(:user).allow(:foo)
        for_roles(:admin).allow(:bar)
      end
      
      @authorization.actions_for(:user).should include(:foo)
      @authorization.actions_for(:user).should_not include(:bar)
      @authorization.actions_for(:admin).should include(:bar)
      @authorization.actions_for(:admin).should_not include(:foo)
    end
    
    it "raises an exception when not called directly after #for_roles" do
      lambda do
        @authorization.instance_eval do
          allow(:foo)
        end
      end.should raise_error
    end
  end
  
  describe "#actions_for(role)" do
    it "returns the previously set actions for the specified role" do
      @authorization.instance_eval do
        for_role(:user).allow(:foo)
      end
      
      @authorization.should respond_to(:actions_for)
      @authorization.actions_for(:user).should include(:foo)
    end
  end
end