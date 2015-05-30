require 'rails_helper'

RSpec.describe Api::V0::PackagesController, type: :controller do

  describe "GET #index" do
    it "returns http 200" do
      package = FactoryGirl.create(:package)
      get :index, format: :json
      response.status.should eq(200)
    end
  end
end
