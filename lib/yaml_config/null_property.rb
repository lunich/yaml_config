class NullProperty
  @@base_values = [{}, [], "", 0, 0.0, nil]
  def ==(val)
    self.equal?(val)
  end
  def equal?(val)
    @@base_values.include?(val)
  end
  def [](key)
    NullProperty.new
  end
  def respond_to?(method)
    @@base_values.any? do |obj|
      obj.respond_to?(method)
    end
  end
  def method_missing(name, *params)
    @@base_values.each do |val|
      return val.send(name, params) if val.respond_to?(name)
    end
    super
  end
end
