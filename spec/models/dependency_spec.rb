require 'rails_helper'

RSpec.describe Dependency, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:dependency).should be_valid
  end

  it { should belong_to(:version) }

  it "invalid without a name" do
    FactoryGirl.build(:dependency, name: nil).should_not be_valid
  end

  it "invalid without a version_constraint" do
    FactoryGirl.build(:dependency, version_constraint: nil).should_not be_valid
  end
end
