module Authorization::OperatorMixin
  def authorized?(args = {})
    @roles ||= Authorization.roles_for(self, args[:target])
    if args[:action].nil?
      @roles.include?(args[:role])
    else
      target = args[:target]._authorization_proxy unless args[:target]._authorization_proxy.nil?
      
      @roles.each do |role|
        actions = target._authorization.actions_for(role)
        return true if actions.include?(args[:action]) || actions.include?(:all)
      end
      false
    end
  end
  
  def roles_for(target)
    Authorization.roles_for(self, target)
  end
end
