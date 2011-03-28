require File.expand_path("../../spec_helper", __FILE__)
require "yaml_config/null_property"

describe NullProperty do
  let :property do
    NullProperty.new
  end
  [{}, [], "", 0, 0.0, nil].each do |obj|
    describe "as #{obj.class} object" do
      it "should be equal to #{obj.inspect}" do
        property.should be_equal(obj)
      end
      it "should == #{obj.inspect}" do
        property.should == obj
      end
      obj.methods.each do |method|
        it "should respond to :#{method}" do
          property.should respond_to(method)
        end
      end
    end
  end
end
