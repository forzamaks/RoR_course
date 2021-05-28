# frozen_string_literal: true

# Acсessors Module
module Acсessors
  def attr_accessor_with_history(*names)

    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| self.class.set_variables(var_name, value) }

      class_variable_set("@@#{name}".to_sym, [])

      define_method("#{name}_history".to_sym) { self.class.class_variable_get("@#{var_name}".to_sym) }
    end
  end

  def set_variables(var_name, value)
    instance_variable_set(var_name, value)
    class_variable_get("@#{var_name}".to_sym).push(value)
  end


  def strong_attr_accessor(value, attr_name, class_name)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=".to_sym) { |value| self.class.validate_class(var_name, value, class_name) }
  end

  def validate_class(var_name, value, class_name)
    unless value.class === class_name
      begin
      raise 'Неверный класс аттрибута'
      rescue RuntimeError => e
        puts e.message
      end
    end
    instance_variable_set(var_name, value)
  end
end

