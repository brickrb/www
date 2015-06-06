require 'rails_helper'

RSpec.describe Api::V0::VersionsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }
  before { controller.stub(:current_user).and_return user }

  context "no access token" do
    it 'returns a 401 when users are not authenticated' do
      post :create, format: :json, version: FactoryGirl.attributes_for(:version)
      response.status.should eq(401)
    end
  end

  context "with access token" do
    before(:each) do
      @oauth_application = FactoryGirl.build(:oauth_application)
      @token = Doorkeeper::AccessToken.create!(:application_id => @oauth_application.id, :resource_owner_id => user.id)
    end

    describe "POST #create" do
      context "valid parameters" do
        it "creates a new version" do
          expect {
            post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version)
          }.to change(Version, :count).by(1)
        end

        it "returns http 201" do
          post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version)
          response.status.should eq(201)
        end
      end

      context "invalid parameters" do
        before(:each) { FactoryGirl.create(:version, number: "1.0") }
        it "does not creates a new package" do
          expect {
            post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version, number: "1.0")
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version, number: "1.0")
          response.status.should eq(422)
        end
      end

      context "invalid parameters" do
        it "does not creates a new package" do
          expect {
            post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version, tarball: nil)
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, version: FactoryGirl.attributes_for(:version, tarball: nil)
          response.status.should eq(422)
        end
      end
    end
  end
end
