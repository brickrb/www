require 'rails_helper'

RSpec.describe Dependency, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:dependency).should be_valid
  end

  it { should belong_to(:version) }
end
