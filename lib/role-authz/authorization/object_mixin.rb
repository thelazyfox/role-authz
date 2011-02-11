class Object
  def self.authorizable!
    include Authorization::OperatorMixin
  end
end
