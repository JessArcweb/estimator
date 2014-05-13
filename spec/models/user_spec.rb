require 'spec_helper'

describe User do
  it "can be instantiated" do
    User.new.should be_an_instance_of (User)
  end

  it "fails validation with no name" do
    User.new.should have(1).error_on(:name)
  end

  it "fails validation with no email" do
    User.new.should have(1).error_on(:email)
  end

  it "fails validation with name and no email" do
    User.new(:name => "test").should have(1).error_on(:email)
  end

  it "fails validation with email and no name" do
    User.new(:email => "test").should have(1).error_on(:name)
  end

  it "can be saved successfully" do
    User.create(:name => "test_name", :email => "test_email@test.com").should be_persisted
  end
end
