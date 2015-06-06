require 'rails_helper'

RSpec.describe Version, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:version).should be_valid
  end

  it { should belong_to(:package) }

  it { should have_attached_file(:tarball) }
  it { should validate_attachment_content_type(:tarball).
    allowing('application/x-gzip').
    rejecting('text/plain', 'text/xml') }
end
