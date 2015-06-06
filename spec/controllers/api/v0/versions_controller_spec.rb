require 'rails_helper'

RSpec.describe Api::V0::VersionsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }
  before { controller.stub(:current_user).and_return user }

  context "no access token" do
  end

  context "with access token" do
    before(:each) do
      @oauth_application = FactoryGirl.build(:oauth_application)
      @token = Doorkeeper::AccessToken.create!(:application_id => @oauth_application.id, :resource_owner_id => user.id)
    end

    describe "POST #create" do
      context "valid parameters" do
        it "creates a new version" do
        end

        it "returns http 201" do
        end
      end

      context "invalid parameters" do
        it "does not creates a new package" do
        end

        it "returns http 422" do
        end
      end
    end
  end
end
