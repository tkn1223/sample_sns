class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存が成功したときの処理
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

    # privateであることを強調するための慣習
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
