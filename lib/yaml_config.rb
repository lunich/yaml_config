require "yaml_config/null_property"

class YamlConfig
  def initialize(filename, options = {})
    @root = options.delete(:root).to_s
    @yaml = File.exists?(filename) ? YAML.load_file(filename) : YAML.load(filename)
    raise NameError.new("Root :#{@root} doesn't exist in given YAML") unless @root.empty? || @yaml.has_key?(@root)
  end
  def get(key)
    (@root.empty? ? @yaml[key.to_s] : @yaml[@root][key.to_s]) || NullProperty.new
  end
end