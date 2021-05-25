module SetName

  def set_company_name(name)
    self.company_name = name
  end

  protected
  attr_writer :company_name
end