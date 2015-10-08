module ParamCapturable
  def self.included(base)
    super

    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods    
      
      class_attribute  :incoming_params 

      self.param_capturable
    end
  end
  module ClassMethods
    def param_capturable(options = {})
      
      class_eval do
        after_create   :make_incoming_param
      end
    end
  end
  
  module InstanceMethods
    
    private
    
    def make_incoming_param
      if !self.incoming_params.blank? and !!Object.const_get(:IncomingParam)
        ip = IncomingParam.new
        ip.source_data = self.incoming_params
        ip.incoming_paramable = self
        ip.save!
      end
    end
  end
end


ActiveRecord::Base.send(:include, ParamCapturable) if defined?(ActiveRecord)

