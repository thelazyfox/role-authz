module Authorization
  @roles = {}
  
  def self.roles_for(operator, target=nil)
    list = []
    @roles.each do |name, proc|
      if proc.call(operator, target)
        list += [name]
      end
    end
    list
  end
  
  def self.add_role(name, &block)
    if block.parameters.count == 2
      @roles[name] = block
    else
      raise InvalidRole
    end
  end
end
