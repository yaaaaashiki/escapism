require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    before do 
      get :index 
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index templete" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
