module Authorization
  @roles = {}
  
  def self.roles_for(operator, target)
    list = []
    @roles.each do |name, proc|
      if proc.call(operator, target)
        list += [name]
      end
    end
    list
  end
  
  def self.add_role(name, &block)
    @roles[name] = block
  end
end
