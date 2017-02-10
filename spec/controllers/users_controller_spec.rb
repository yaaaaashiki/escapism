require 'rails_helper'

# 書き途中www
RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    before do 
      get :index 
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index templete" do
      expect(response).to render_template(:index)
    end

    it "assign true into @bookBack" do
      expect(assigns(:bookBack)).to be true
    end
  end

  describe "GET #new" do
    before do 
      get :new
    end

    context "exist Token in database" do
      before do
        Token.create()
      end

      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "renders the new templete" do
        expect(response).to redirect_to(search_url)
      end
    end

    context "not exist Token in database" do
      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "renders the new templete" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    before do 
      post :create 
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the create templete" do
      expect(response).to render_template(:create)
    end
  end

end
