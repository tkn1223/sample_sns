require 'rails_helper'

RSpec.describe "UsersLogouts", type: :request do
  describe "GET /logout" do

    let!(:user) { FactoryBot.create(:user) }

    before do
      post login_path, params: { sessions: { email: user.email, password: user.password } }
    end

    it "ログアウトが正しく実行されることを確認" do
      # ログインできているかを確認
      follow_redirect!
      expect(response).to render_template("users/show")
      expect(response.body).to include('id="account"')

      # ログアウト処理
      delete logout_path

      # ログアウトされたか
      expect(session[:user_id]).to be_nil
      # 303リダイレクト
      expect(response).to have_http_status(:see_other)
      # ホームへリダイレクトされたか
      expect(response).to redirect_to(root_path)
      follow_redirect!
      # ログインリンクがあることを確認
      expect(response.body).to include("href=\"#{login_path}\"")
    end
  end
end
