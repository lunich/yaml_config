require "yaml_config/null_property"

class YamlConfig
  def initialize(file, options = {})
    @root = options.delete(:root).to_s
    @yaml = if file.respond_to?(:read)
      YAML.load(file.read)
    elsif file.is_a?(String)
      File.exists?(file) ? YAML.load_file(file) : YAML.load(file)
    end
    
    raise Exception.new("File is not valid YAML") unless @yaml.is_a?(Hash)
    raise NameError.new("Root :#{@root} doesn't exist in given YAML") unless @root.empty? || @yaml.has_key?(@root)
  end

  def get(key)
    (@root.empty? ? @yaml[key.to_s] : @yaml[@root][key.to_s]) || NullProperty.new
  end
end
