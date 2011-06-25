require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  include ActsAsTaggableOn

  context :permalink do
    it "responds to :permalink" do
      Tag.new.should respond_to(:permalink)
    end

    it "stores permalink value on create" do
      Tag.create(:name => 'ruby').permalink.should == 'ruby'  
    end

    it "transliterates tag name for permalink value" do
      Tag.create(:name => 'руби').permalink.should == 'rubi'
    end

    it "replaces dots with dashes" do
      Tag.create(:name => 'ruby.su').permalink.should == 'ruby-su'
    end
  end

  context :to_param do
    it "returns permalink value of the tag" do
      pending
      Tag.new(:permalink => 'ruby').to_param.should == 'ruby'
    end

  end
end
