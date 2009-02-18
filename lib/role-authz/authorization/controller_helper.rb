module Authorization
  class OpenForRoleStatement < Exception; end
  class NoCurrentForRoleStatement < Exception; end
  
  class ControllerHelper
    def initialize
      @working_roles = []
      @permissions_list = {}
    end
  
    def for_roles(*the_roles)
      raise OpenForRoleStatement unless @working_roles.empty?
      @working_roles += the_roles
      self
    end
    alias_method :for_role, :for_roles
    
    def allow(*the_actions)
      raise NoCurrentForRoleStatement unless !@working_roles.empty?
      @working_roles.each do |current_role|
        if !@permissions_list.include?(current_role)
          @permissions_list[current_role] = []
        end
        @permissions_list[current_role] += the_actions
      end
      @working_roles.clear
      self
    end
    
    def actions_for(role)
      @permissions_list[role] || []
    end
  end
end
