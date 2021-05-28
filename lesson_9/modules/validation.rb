# frozen_string_literal: true

# Validation Module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end


   # ClassMethods Module
  module ClassMethods
    @@validations = {}
    def validate(name, type, *params)
      var_validate = {name: name, type: type, params: params}
      instance_variable_set("@validations".to_sym, []) unless instance_variable_get("@validations".to_sym)
      
      instance_variable_get("@validations".to_sym).push(var_validate)
      @@validations[self.name] = var_validate

    end

    def valid
      puts instance_variable_get("@validations".to_sym)
      @@validations
    end


    
   
  end

  # InstanceMethods Module
  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get("@validations".to_sym)
      errors = []
      validations.each do |validation|
        current = instance_variable_get("@#{validation[:name]}".to_sym)
        case validation[:type]
        when :presence
          errors << 'Не может быть пустым' if current.length.zero? || current.nil?
        when :format
          errors << 'Неверный формат номера' if current !~ validation[:params]
        when :type
          errors << 'Несоответсвует указанному типу данных' if self.class != validation[:params]
        end
      end
      raise errors.join('. ') unless errors.empty?
    end

    def valid?
      begin
        validate!
      rescue RuntimeError => e
        puts e.message
      end
    end
  end


end