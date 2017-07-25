require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    let!(:mail) {create(:mail_address)}

    context "exist Token in database" do
      it "returns http success" do
        token = Token.create(token: "Token135", mail_address_id: mail.id)
        get :new, params: {token: token.token}
        expect(response).to have_http_status(:success)
      end

      it "renders the new templete" do
        token = Token.create(token: "Token135", mail_address_id: mail.id)
        get :new, params: {token: token.token}
        expect(response).to render_template(:new)
      end
    end

    context "not exist Token in database" do
      let(:token) {build(:token)}

      it "returns http redirect" do
        get :new, params: {token: token.token}
        expect(response).to have_http_status(:redirect)
      end

      it "redirect to root_path" do
        get :new, params: {token: token.token}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "new user saved" do
      let(:it_aoyama_user) {build(:it_aoyama_user)}
      let!(:mail) {create(:mail_address)}
      let(:token) {create(:token)}

      before do
        @it_aoyama_user_hash = attributes_for(:it_aoyama_user)
      end

      it "new user saved" do
        post :create, params: {user: @it_aoyama_user_hash}
        expect(User.exists?(username: it_aoyama_user.username)).to be true
      end

      it "logged in" do
        post :create, params: {user: @it_aoyama_user_hash}
        expect(session[:user_id]).to be assigns(:user).id
      end

      it "returns http redirect" do
        post :create, params: {user: @it_aoyama_user_hash}
        expect(response).to have_http_status(:redirect)
      end

      it "redirect to users_url" do
        post :create, params: {user: @it_aoyama_user_hash}
        expect(response).to redirect_to(users_path)
      end
    end

    context "new user not saved" do
      context "no name" do
        let(:no_name_user) {build(:no_name_user)}
        let!(:mail) {create(:mail_address)}
        let(:token) {create(:token)}

        before do
          @no_name_user_hash = attributes_for(:no_name_user)
        end

        it "new user not saved" do
          post :create, params: {user: @no_name_user_hash}
          expect(User.exists?(email: no_name_user.email)).to be false
        end

        it "returns http success" do
          post :create, params: {user: @no_name_user_hash}
          expect(response).to have_http_status(:success)
        end

        it "renders the new templete" do
          post :create, params: {user: @no_name_user_hash}
          expect(response).to render_template(:new)
        end

     end

      context "no mail" do
        let(:no_mail_user) { build(:no_mail_user) }
        let!(:mail) {create(:mail_address)}
        let(:token) {create(:token)}

        before do
          @no_mail_user_hash = attributes_for(:no_mail_user)
        end

        it "new user not saved" do
          post :create, params: {user: @no_mail_user_hash}
          expect(User.exists?(username: no_mail_user.username)).to be false
        end

        it "returns http success" do
          post :create, params: {user: @no_mail_user_hash}
          expect(response).to have_http_status(:success)
        end

        it "renders the new templete" do
          post :create, params: {user: @no_mail_user_hash}
          expect(response).to render_template(:new)
        end
     end
    end
  end
end
