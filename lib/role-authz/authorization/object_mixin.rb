class Object
  class_inheritable_accessor :_authorization_proxy
  
  def self.authorizable!
    include Authorization::OperatorMixin
  end

end
