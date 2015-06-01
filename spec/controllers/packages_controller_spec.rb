require 'rails_helper'

RSpec.describe PackagesController, type: :controller do

  describe "GET #show" do
    it "renders the show template and returns http 200" do
      @package = FactoryGirl.create(:package)
      
      get :show, name: @package
      response.should render_template("show")
      response.status.should eq(200)
    end
  end

end
