require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "Get #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
   
    it "renders the new templete" do
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe "Post #create" do
    context "login success" do
      let!(:it_aoyama_user) {create(:it_aoyama_user)}

      context "it_aoyama_user" do
        before do
          @it_aoyama_user_hash = attributes_for(:it_aoyama_user)
        end

        it "returns http success" do
          post :create, params: {session: @it_aoyama_user_hash}
          expect(response).to have_http_status(:redirect)
        end

        it "redirect the thesis path" do
          post :create, params: {session: @it_aoyama_user_hash}
          expect(response).to redirect_to(theses_path)
        end
      end
    end

    context "login failed" do
      context "no database user" do
        let!(:it_aoyama_user) {build(:it_aoyama_user)}
        before do
          @it_aoyama_user_hash = attributes_for(:it_aoyama_user)
        end

        it "return http success" do
          post :create, params: {session: @it_aoyama_user_hash}
          expect(response).to have_http_status(:unauthorized)
        end

        it "render new template" do
          post :create, params: {session: @it_aoyama_user_hash}
          expect(response).to render_template(:new)
        end
      end

      context "database user" do
        let!(:it_aoyama_user) {create(:it_aoyama_user)}

        context "only input user name" do
          before do
            @user_hash_except_password = attributes_for(:it_aoyama_user)
            @user_hash_except_password.delete(:password)
          end

          it "return http success" do
            post :create, params: {session: @user_hash_except_password}
            expect(response).to have_http_status(:unauthorized)
          end

          it "render new template" do
            post :create, params: {session: @user_hash_except_password}
            expect(response).to render_template(:new)
          end
        end

        context "only input password" do
          let!(:it_aoyama_user) {create(:it_aoyama_user)}
          before do
            @user_hash_except_email = attributes_for(:it_aoyama_user)
            @user_hash_except_email.update(email: "") # ブラウザからメールが入力されない場合は空文字が来る
          end

          it "return http success" do
            post :create, params: {session: @user_hash_except_email}
            expect(response).to have_http_status(:unauthorized)
          end

          it "render new template" do
            post :create, params: {session: @user_hash_except_email}
            expect(response).to render_template(:new)
          end
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:it_aoyama_user) {create(:it_aoyama_user)}

    before do
      login_user it_aoyama_user
    end

    it "return http redirect" do
      delete :destroy
      expect(response).to have_http_status(:redirect)
    end

    it "redirect the root path" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it "logout success" do
      delete :destroy
      expect(session[:user_id]).to eq nil
    end
  end
end
