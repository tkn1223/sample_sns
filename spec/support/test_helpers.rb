# spec/support/test_helpers.rb
module TestHelpers
  # ログインしているか確認するヘルパー
  def is_logged_in?
    !session[:user_id].nil?
  end

  # コントローラスペック用：セッションを直接操作してログイン
  def log_in_directly(user)
    session[:user_id] = user.id
  end

  # リクエストスペック用：POSTでログイン処理を模倣
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: {
      session: {
        email: user.email,
        password: password,
        remember_me: remember_me
      }
    }
  end
end