require 'rails_helper'

RSpec.describe Ownership, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:ownership).should be_valid
  end

  it { should belong_to(:package) }
  it { should belong_to(:user) }
end
