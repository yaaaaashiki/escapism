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

        it "redirect the thesis templete" do
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
          post :create, params: {session: {user: @it_aoyama_user_hash}}
          expect(response).to have_http_status(:success)
        end

        it "render new template" do
          post :create, params: {session: {user: @it_aoyama_user_hash}}
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
            post :create, params: {session: {user: @user_hash_except_password}}
            expect(response).to have_http_status(:success)
          end

          it "render new template" do
            post :create, params: {session: {user: @user_hash_except_password}}
            expect(response).to render_template(:new)
          end
        end

        context "only input password" do
          let!(:it_aoyama_user) {create(:it_aoyama_user)}
          before do
            @user_hash_except_username = attributes_for(:it_aoyama_user)
            @user_hash_except_username.delete(:username)
          end

          it "return http success" do
            post :create, params: {session: {user: @user_hash_except_username}}
            expect(response).to have_http_status(:success)
          end

          it "render new template" do
            post :create, params: {session: {user: @user_hash_except_username}}
            expect(response).to render_template(:new)
          end
        end

      end
    end
  end
end
