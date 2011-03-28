require "yaml_config/yaml_config"
require "singleton"

class AppYamlConfig
  include Singleton
  
  def init!(file, options = {})
    @yaml_config = YamlConfig.new(file, options)
    self
  end
  
  def respond_to?(name)
    super || @yaml_config.respond_to?(name)
  end
  
  def method_missing(name, *params)
    @yaml_config.respond_to?(name) ?
      @yaml_config.send(name, *params) :
      super
  end
  
end