require File.dirname(__FILE__) + '/../spec_helper'
require "yaml_config/yaml_config"

shared_examples_for "Yaml without root" do
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

shared_examples_for "Yaml with :root => :test" do
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

describe YamlConfig do
  describe "with valid yaml" do
    let :filename do
      File.join(File.dirname(__FILE__), "../files/valid_config.yml")
    end
    describe "with data" do
      let :data do
        File.read(filename)
      end
      describe "without :root" do
        let :config do
          YamlConfig.new(data)
        end
        it_should_behave_like "Yaml without root"
      end
      describe "with :root => :test" do
        let :config do
          YamlConfig.new(data, :root => :test)
        end
        it_should_behave_like "Yaml with :root => :test"
      end
    end
    describe "with open file" do
      let :file do
        File.open(filename, "r")
      end
      describe "without :root" do
        let :config do
          YamlConfig.new(file)
        end
        it_should_behave_like "Yaml without root"
      end
      describe "with :root => :test" do
        let :config do
          YamlConfig.new(file, :root => :test)
        end
        it_should_behave_like "Yaml with :root => :test"
      end
    end
    describe "without :root" do
      let :config do
        YamlConfig.new(filename)
      end
      it_should_behave_like "Yaml without root"
    end
    describe "with :root => :test" do
      let :config do
        YamlConfig.new(filename, :root => :test)
      end
      it_should_behave_like "Yaml with :root => :test"
    end
    describe "with invalid root" do
      it "should raise error" do
        lambda do
          YamlConfig.new(filename, :root => :demo)
        end.should raise_exception(NameError)
      end
    end
  end
  describe "with invalid yaml" do
    let :filename do
      File.join(File.dirname(__FILE__), "../files/invalid_config.yml")
    end
    it "should raise error" do
      lambda do
        YamlConfig.new(filename, :root => :demo)
      end.should raise_exception(Exception)
    end
  end
end
