module Authorization
  class ResourceHelper
    def initialize
      @working_roles = []
      @create_list = {}
      @modify_list = {}
    end
  
    def for_roles(*the_roles)
      raise OpenForRoleStatement unless @working_roles.empty?
      @working_roles = the_roles.clone
      self
    end
    alias_method :for_role, :for_roles
    
    def create(*the_properties)
      raise NoCurrentForRoleStatement unless !@working_roles.empty?
      @working_roles.each do |current_role|
        @create_list[current_role] ||= []
        @create_list[current_role] += the_properties
      end
      @working_roles.clear
      self
    end
    
    def modify(*the_properties)
      raise NoCurrentForRoleStatement unless !@working_roles.emtpy?
      @working_roles.each do |current_role|
        @create_list[current_role] ||= []
        @create_list[current_role] += the_properties
      end
      @working_roles.clear
      self
    end
    
    def creatable_by(*the_roles)
      properties = []
      the_roles.each do |current_role|
      end
    end
    
    def modifiable_by(*the_role)
      the_roles.each do |current_role|
      end
    end
  end
end
