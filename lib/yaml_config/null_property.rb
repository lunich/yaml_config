class NullProperty
  @@base_values = [{}, [], "", 0, 0.0, nil]
  
  def to_s
    ""
  end

  def to_i
    0
  end

  def to_f
    0.0
  end

  def to_a
    []
  end

  def nil?
    true
  end
  
  def ==(val)
    super || @@base_values.any? { |v| v == val }
  end

  def [](key)
    NullProperty.new
  end
  
  def instance_of?(klass)
    super || @@base_values.any? { |v| v.instance_of?(klass) }
  end

  def respond_to?(method)
    super || @@base_values.any? { |v| v.respond_to?(method) }
  end

  def method_missing(name, *params)
    @@base_values.each do |val|
      return val.send(name, *params) if val.respond_to?(name)
    end
    super
  end
end
