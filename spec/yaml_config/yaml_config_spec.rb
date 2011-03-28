require File.dirname(__FILE__) + '/../spec_helper'

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
