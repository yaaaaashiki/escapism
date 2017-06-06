class MailAddressesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  SUBJECT  = "論文検索システム Escapism です"

  def new
    @mail = MailAddress.new
  end

  def create
    send_email(params[:address][:name]) if MailAddress.create(address: params[:address][:name]).valid?
    redirect_to root_path
  end

  private

    def send_email(address)
      Admin::InviteUserMailer.invite(address, SUBJECT).deliver
    end
end
