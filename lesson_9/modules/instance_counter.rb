# frozen_string_literal: true

# InstanceCounter Module
module InstanceCounter
  attr_accessor :instances

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # ClassMethods Module
  module ClassMethods
    # rubocop:disable Style/ClassVars
    @@instances = {}
    # rubocop:enable Style/ClassVars
    def instances
      @@instances[self]
    end

    def increment(initialize_class)
      @@instances[initialize_class] = if @@instances[initialize_class]
                                        @@instances[initialize_class] + 1
                                      else
                                        1
                                      end
    end
  end

  # InstanceMethods Module
  module InstanceMethods
    protected

    def register_instance(initialize_class)
      self.class.increment(initialize_class)
    end
  end
end
