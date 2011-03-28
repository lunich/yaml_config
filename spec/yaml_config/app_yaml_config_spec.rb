require File.dirname(__FILE__) + '/../spec_helper'

describe AppYamlConfig do
  describe "should be singleton" do
    it "have no initialize method" do
      lambda do
        AppYamlConfig.new
      end.should raise_error
    end
    it "should have :instance method" do
      AppYamlConfig.instance.should be_instance_of(AppYamlConfig)
    end
  end
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
          AppYamlConfig.instance.init!(data)
        end
        it { config.should be_instance_of(AppYamlConfig) }
        it_should_behave_like "Yaml without root"
      end
      describe "with :root => :test" do
        let :config do
          AppYamlConfig.instance.init!(data, :root => :test)
        end
        it { config.should be_instance_of(AppYamlConfig) }
        it_should_behave_like "Yaml with :root => :test"
      end
      describe "with open file" do
        let :file do
          File.open(filename, "r")
        end
        describe "without :root" do
          let :config do
            AppYamlConfig.instance.init!(file)
          end
          it { config.should be_instance_of(AppYamlConfig) }
          it_should_behave_like "Yaml without root"
        end
        describe "with :root => :test" do
          let :config do
            AppYamlConfig.instance.init!(file, :root => :test)
          end
          it { config.should be_instance_of(AppYamlConfig) }
          it_should_behave_like "Yaml with :root => :test"
        end
      end
      describe "without :root" do
        let :config do
          AppYamlConfig.instance.init!(filename)
        end
        it { config.should be_instance_of(AppYamlConfig) }
        it_should_behave_like "Yaml without root"
      end
      describe "with :root => :test" do
        let :config do
          AppYamlConfig.instance.init!(filename, :root => :test)
        end
        it { config.should be_instance_of(AppYamlConfig) }
        it_should_behave_like "Yaml with :root => :test"
      end
      describe "with invalid root" do
        it "should raise error" do
          lambda do
            AppYamlConfig.instance.init!(filename, :root => :demo)
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
          AppYamlConfig.instance.init!(filename, :root => :demo)
        end.should raise_exception(Exception)
      end
    end
  end
end
