require 'rails_helper'

RSpec.describe Api::V0::PackagesController, type: :controller do

  describe "GET #index" do
    it "returns http 200" do
      package = FactoryGirl.create(:package)
      get :index, format: :json
      response.status.should eq(200)
    end
  end

  describe "POST #create" do
    context "valid parameters" do
      it "creates a new package" do
        expect {
          post :create, format: :json, package: FactoryGirl.attributes_for(:package)
        }.to change(Package, :count).by(1)
      end

      it "returns http 201" do
        post :create, format: :json, package: FactoryGirl.attributes_for(:package)
        response.status.should eq(201)
      end
    end

    context "invalid parameters" do
      before(:each) { FactoryGirl.create(:package, name: "rails") }

      it "does not creates a new package" do
        expect {
          post :create, format: :json, package: FactoryGirl.attributes_for(:package, name: "rails")
        }.to change(Package, :count).by(0)
      end

      it "returns http 422" do
        post :create, format: :json, package: FactoryGirl.attributes_for(:package, name: "rails")
        response.status.should eq(422)
      end
    end
  end

  describe "GET #show" do
    context "valid package" do
      it "returns http 200" do
        package = FactoryGirl.create(:package, name: "rails")
        get :show, format: :json, name: "rails"
        response.status.should eq(200)
      end
    end

    context "invalid package" do
      it "returns http 404" do
        get :show, format: :json, name: "test"
        response.status.should eq(404)
      end
    end
  end
end
