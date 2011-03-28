require File.dirname(__FILE__) + '/../spec_helper'

describe NullProperty do
  let :property do
    NullProperty.new
  end
  [{}, [], "", 0, 0.0, nil].each do |obj|
    describe "as #{obj.class} object" do
      it { property.should == obj }
      it { property.should be_instance_of(obj.class) }
      obj.methods.each do |method|
        it { property.should respond_to(method) }
      end
    end
  end
  describe "[] method" do
    describe "should return NullProperty object" do
      it "with string key" do
        property["property"].should be_instance_of(NullProperty)
      end
      it "with symbol key" do
        property[:property].should be_instance_of(NullProperty)
      end
      it "with integer key" do
        property[0].should be_instance_of(NullProperty)
      end
    end
  end
  it { property.to_s.should == "" }
  it { property.to_f.should == 0.0 }
  it { property.to_i.should == 0 }
  it { property.to_a.should == [] }
  it { property.should be_nil }
  it { property.should be_empty }
end
