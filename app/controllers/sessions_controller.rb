class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user&.authenticate(params[:sessions][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
  end
end
