class Authorization
  class ResourceMixin
    class_inheritable_accessor :_resource_authorization
    
    def self.authorize(&block)
      self._resource_authorization ||= Authorization::ResourceHelper.new
      self._resource_authorization.instance_eval(&block) if block_given?
      self._resource_authorization
    end
  end
end