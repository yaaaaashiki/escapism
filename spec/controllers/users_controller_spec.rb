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
      expect(response).to render_template(:index)
    end

    it "assign true into @bookBack" do
      expect(assigns(:bookBack)).to be true
    end
  end

  describe "GET #new" do
    context "exist Token in database" do
      let(:token) { create(:token) }

      before do 
        get :new, params: {token: token.token}
      end

      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirect to search_url" do
        expect(response).to redirect_to(search_url)
      end
    end

    context "not exist Token in database" do
      before do 
        get :new, params: {token: "unexistedToken1"}
      end

      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "new user saved" do
      let(:user) { build(:user) }

      before do 
        post :create, params: {user: attributes_for(:user)}
      end

      it "new user saved" do
        expect(User.exists?(username: user.username)).to be true
      end

      it "logged in" do
        expect(session[:user_id]).to be assigns(:user).id
      end

      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirect to users_url" do
        expect(response).to redirect_to(users_path)
      end
    end

    context "new user not saved" do
      context "no name" do
        let(:user) { build(:no_name_user) }

        before do 
          post :create, params: {user: attributes_for(:no_name_user)}
        end

        it "new user not saved" do
          expect(User.exists?(email: user.email)).to be false
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "renders the new templete" do
          expect(response).to render_template(:new)
        end

        it "assign true into @bookBack" do
          expect(assigns(:bookBack)).to be true
        end
      end

      context "no mail" do
        let(:user) { build(:no_mail_user) }

        before do 
          post :create, params: {user: attributes_for(:no_mail_user)}
        end

        it "new user not saved" do
          expect(User.exists?(username: user.username)).to be false
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "renders the new templete" do
          expect(response).to render_template(:new)
        end

        it "assign true into @bookBack" do
          expect(assigns(:bookBack)).to be true
        end
      end
    end
  end
end
