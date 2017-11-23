class MailAddressesController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :correct_request?, only: [:index]
  SUBJECT  = "【論文検索システム Escapism】 ユーザ登録ページのご案内"

  def index
  end

  def new
    @mail = MailAddress.new
  end

  def create
    @mail = MailAddress.new(address: params[:address][:name])
    if @mail.save == false
      render :new, status: :bad_request
      return
    end
    send_email(@mail.address)
    redirect_to mail_addresses_path
  end

  private
    def send_email(address)
      Admin::InviteUserMailer.invite(address, SUBJECT).deliver
    end

    def correct_request?
      @request = Rails.application.routes.recognize_path(request.referrer)
      raise ActionController::RoutingError.new('Please input mail address by sign up page') unless (@request[:action] == "new" || "index") && (@request[:controller] == "mail_addresses")
    end
end
