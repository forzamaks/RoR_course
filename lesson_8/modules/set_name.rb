# frozen_string_literal: true

# SetName Module
module SetName
  def assign_company_name(name)
    self.company_name = name
  end

  protected

  attr_writer :company_name
end
