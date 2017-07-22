require 'rails_helper'

RSpec.describe UsersController, type: :controller do




  describe "GET #new" do
    let(:user) {create(:it_aoyama_user)}
    let!(:mail) {create(:mail_address)}
   

#######################↓↓↓↓↓↓↓↓↓↓要修正↓↓↓↓↓↓↓↓↓↓###############################
    context "exist Token in database" do
      #let(:token) {create(:token)}

      xit "returns http success" do
        #MailAddress id == 1 を向いてる
        get :new, params: {token: token.token}
        expect(response).to have_http_status(:success)
      end
      xit "renders the new templete" do
        #MailAddress id == 2 を向いてる
        binding.pry
        get :new, params: {token: token.token}
        expect(response).to render_template(:new)
      end
    end
#######################要修正###############################


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
      let(:it_aoyama_user) {create(:it_aoyama_user)}
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



#######################↓↓↓↓↓↓↓↓↓↓要修正↓↓↓↓↓↓↓↓↓↓###############################
      xit "returns http redirect" do
        post :create, params: {user: @it_aoyama_user_hash}
        #success ?? redirect???
        expect(response).to have_http_status(:redirect)
      end

      xit "redirect to users_url" do
        post :create, params: {user: @it_aoyama_user_hash}
        expect(response).to redirect_to(users_path)
      end
    end
#######################↑↑↑↑↑↑↑↑↑↑要修正↑↑↑↑↑↑↑↑↑↑###############################


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
