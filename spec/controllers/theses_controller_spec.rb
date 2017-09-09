require 'rails_helper'

RSpec.describe ThesesController, type: :controller do

  describe "GET #index" do
    let!(:it_aoyama_user) {create(:it_aoyama_user)}

    before do
      login_user it_aoyama_user
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the new templete" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
