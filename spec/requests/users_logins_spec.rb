require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  let(:user) { create(:user) }

  describe "GET /login" do
    it "ログインページのフラッシュが他画面に残らないか確認" do
      get login_path
      expect(response).to render_template(:new)

      post login_path, params: { session: { email: "", password: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)

      # フラッシュメッセージが存在すること
      expect(flash[:danger]).to be_present

      get root_path

      # フラッシュがクリアされていること
      expect(flash[:danger]).to be_nil
    end

    # ログイン前後のトグル表記についてテスト
    it "未ログイン時にはaccountメニューが表示されないことを確認" do
      get root_path  # もしくは get login_path など、未ログインでアクセス
      expect(response.body).not_to include('id="account"')
    end

    it "ログイン時にはaccountメニューが表示されることを確認" do
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response).to redirect_to(user)

      # リダイレクト先へ移動
      follow_redirect!
      expect(response).to render_template("users/show")

      # HTMLのリンクが正しく存在することを確認
      expect(response.body).to include("href=\"#{logout_path}\"")
      expect(response.body).to include("href=\"#{user_path(user)}\"")
    end
  end
end
