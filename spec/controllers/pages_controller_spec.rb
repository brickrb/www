require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "renders the index template and returns http 200" do
      get :home
      response.should render_template("home")
      response.status.should eq(200)
    end
  end

end
