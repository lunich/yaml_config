require File.dirname(__FILE__) + '/../spec_helper'
require "yaml_config/yaml_config"

describe YamlConfig do
  describe "with valid yaml" do
    let :valid_filename do
      File.join(File.dirname(__FILE__), "files/valid_config.yml")
    end
    describe "without :root" do
      let :config do
        YamlConfig.new(valid_filename)
      end
      it { config.get(:development).should be_instance_of(Hash) }
      it { config.get(:development).keys.should == ["duration", "username", "url"] }

      it { config.get(:development)["username"].should be_instance_of(String) }
      it { config.get(:development)["username"].should == "Dev" }
      
      it { config.get(:development)["url"].should be_instance_of(Hash) }
      it { config.get(:development)["url"]["protocol"].should be_instance_of(String) }
      it { config.get(:development)["url"]["protocol"].should == "http" }
      it { config.get(:development)["url"]["host"].should be_instance_of(String) }
      it { config.get(:development)["url"]["host"].should == "localhost" }
      it { config.get(:development)["url"]["port"].should be_instance_of(Fixnum) }
      it { config.get(:development)["url"]["port"].should == 8080 }
      
      it { config.get(:development)["duration"].should be_instance_of(Float) }
      it { config.get(:development)["duration"].should == 0.0 }
    
      it { config.get(:trunk).should be_instance_of(NullProperty) }
    end
    describe "with :root => :test" do
      let :config do
        YamlConfig.new(valid_filename, :root => :test)
      end
      it { config.get(:username).should be_instance_of(String) }
      it { config.get(:username).should == "Test" }
                       
      it { config.get(:url).should be_instance_of(Hash) }
      it { config.get(:url)["protocol"].should be_instance_of(String) }
      it { config.get(:url)["protocol"].should == "https" }
      it { config.get(:url)["host"].should be_instance_of(String) }
      it { config.get(:url)["host"].should == "test.host" }
      it { config.get(:url)["port"].should be_instance_of(Fixnum) }
      it { config.get(:url)["port"].should == 3000 }
                       
      it { config.get(:duration).should be_instance_of(Float) }
      it { config.get(:duration).should == 0.1 }
    
      it { config.get(:trunk).should be_instance_of(NullProperty) }
    end
    describe "with invalid root" do
      it "should raise error" do
        lambda do
          YamlConfig.new(valid_filename, :root => :demo)
        end.should raise_exception(NameError)
      end
    end
  end
end
