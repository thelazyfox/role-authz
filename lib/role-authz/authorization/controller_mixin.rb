class Merb::Controller
  class Unauthorized < Merb::Controller::Forbidden; end
  class_inheritable_accessor :_authorization
  class_inheritable_accessor :_authorization_target
  
  def self.role(name, &block)
    Authorization.add_role(name, &block)
  end
  
  def self.authorize(klass, &block)
    klass.class_inheritable_accessor :_authorization_proxy
    klass._authorization_proxy = self
    self._authorization_target = klass
    self._authorization ||= Authorization::ControllerHelper.new
    self._authorization.instance_eval(&block) if block_given?
    before :ensure_authorized
    self._authorization
  end
  
  def authorization_target
    if _authorization_target.respond_to?(:get)
      _authorization_target.get(params[:id])
    else
      nil
    end
  end
  
  def ensure_authorized
    operator = (session.user if session.authenticated?)
    roles = Authorization.roles_for(operator, authorization_target)
    roles.each do |role|
      actions = self.class._authorization.actions_for(role)
      return true if actions.include?(params[:action].to_sym) || actions.include?(:all)
    end
    if session.authenticated?
      raise Unauthorized
    else
      raise Unauthenticated
    end
  end
end
