module InstanceCounter

  attr_accessor :instances
  

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = Hash.new


    def instances
      @@instances[self]
    end

    def increment(initializeClass)
      if @@instances[initializeClass]
        @@instances[initializeClass] = @@instances[initializeClass] + 1
      else
        @@instances[initializeClass] = 1
      end
      
    end

  end

  module InstanceMethods
    protected

    def register_instance(initializeClass)
      self.class.increment(initializeClass)
    end

  end
end