module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
        session[:user_id] = user.id
    end

    # 永続的セッションのためにユーザー情報をブラウザに記憶する
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # 記憶トークンcookieに対応するユーザーを返す
    def current_user
        # セッション内にuser_idが存在するか確認
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        # remember me機能が使えるか確認
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    # ログアウトの処理
    def log_out
        reset_session
        @current_user = nil
    end
end
