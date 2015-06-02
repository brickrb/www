require 'rails_helper'

RSpec.describe Version, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:version).should be_valid
  end

  it { should belong_to(:package) }
end
