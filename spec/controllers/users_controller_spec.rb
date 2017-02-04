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


  describe "GET #new" do
    it "render the show templete" do
      get :show, params: { id: sake }
      expect(response).to render_template(:show)
    end
  end



#  describe "GET #index" do
#    let!(:bear) { create(:sake, name: "ビール") }
#    let!(:gin) { create(:sake, name: "ジン") }
#    before do
#      get :index
#    end
#
#    it "returns http success" do
#      expect(response).to have_http_status(:success)
#    end
#
#    it "assigns all sakes" do
#      expect(assigns(:sakes)).to match_array([bear,gin])
#    end
#
#    it "renders the index templete" do
#      get :index
#      expect(response).to render_template(:index)
#    end
#  end
#
#  describe "GET #show" do
#    let(:sake) { create(:sake) }
#    it "assigns the requested sake" do
#      get :show, params: { id: sake }
#      expect(assigns(:sake)).to eq(sake)
#    end
#
#    it "render the show templete" do
#      get :show, params: { id: sake }
#      expect(response).to render_template(:show)
#    end
#  end

end
