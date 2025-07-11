class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "情報の更新が完了しました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

    # privateであることを強調するための慣習
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeフィルタ
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "自身のアカウントでログインしてください"
        redirect_to login_url, status: :see_other
      end
    end
end
