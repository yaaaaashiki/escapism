class MailAddressesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  SUBJECT  = "論文検索システム Escapism です"

  def index
  end

  def new
    @mail = MailAddress.new
  end

  def create
    @mail = MailAddress.new(address: params[:address][:name])
    if @mail.invalid?
      binding.pry
      render :new
    else
      @mail.save
      send_email(params[:address][:name])
      redirect_to root_path
    end
  end

  private

    def send_email(address)
      Admin::InviteUserMailer.invite(address, SUBJECT).deliver
    end
end
