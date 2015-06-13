require 'rails_helper'

RSpec.describe Api::V0::VersionsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }
  before { controller.stub(:current_user).and_return user }

  context "no access token" do
    before(:each) do
      @package = FactoryGirl.create(:package)
      @version = FactoryGirl.create(:version, package_id: @package.id)
    end
    it 'returns a 401 when users are not authenticated' do
      post :create, format: :json, package_name: @package.name, version: FactoryGirl.attributes_for(:version)
      response.status.should eq(401)
    end
    it 'returns a 401 when users are not authenticated' do
      delete :destroy, format: :json, package_name: @package.name, version_number: @version.number
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
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          expect {
            post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, package_id: @package.id)
          }.to change(Version, :count).by(1)
        end

        it "returns http 201" do
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, package_id: @package.id)
          response.status.should eq(201)
        end
      end

      context "invalid parameters (invalid version number)" do
        before(:each) { FactoryGirl.create(:version, number: "1.0") }
        it "does not creates a new version" do
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          expect {
            post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, number: "1.0")
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, number: "1.0")
          response.status.should eq(422)
        end
      end

      context "invalid parameters (no tarball)" do
        it "does not creates a new version" do
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          expect {
            post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, tarball: nil)
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          @package = FactoryGirl.create(:package)
          @ownership = FactoryGirl.create(:ownership, package_id: @package.id, user_id: user.id)
          post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version, tarball: nil)
          response.status.should eq(422)
        end
      end

      context "invalid parameters (invalid permissions)" do
        it "does not creates a new version" do
          @package = FactoryGirl.create(:package)
          expect {
            post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version)
          }.to change(Version, :count).by(0)
        end

        it "returns http 401" do
          @package = FactoryGirl.create(:package)
          post :create, format: :json, access_token: @token.token, package_name: @package.name, version: FactoryGirl.attributes_for(:version)
          response.status.should eq(401)
        end
      end
    end

    describe "DELETE #destroy" do
      context "valid parameters" do
        before(:each) { @package = FactoryGirl.create(:package, name: "rails") }
        before(:each) { @ownership = FactoryGirl.create(:ownership) }
        before(:each) { @version = FactoryGirl.create(:version) }
        it "deletes the version" do
          expect {
            delete :destroy, format: :json, access_token: @token.token, package_name: @package.name, version_number: @version.number
          }.to change(Version, :count).by(-1)
        end

        it "returns http 204" do
          delete :destroy, format: :json, access_token: @token.token, package_name: @package.name, version_number: @version.number
          response.status.should eq(204)
        end
      end
    end
  end
end
