require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /login" do
    it "ログインページのフラッシュが他画面に残らないか確認" do
      get login_path
      expect(response).to render_template(:new)

      post login_path, params: { sessions: { email: "",password: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)

      # フラッシュメッセージが存在すること
      expect(flash[:danger]).to be_present

      get root_path
      
      # フラッシュがクリアされていること
      expect(flash[:danger]).to be_nil
    end

    # ログイン前後のトグル表記についてテスト（未実装）

    let(:user) { FactoryBot.create(:user) }

    it "未ログイン時にはaccountメニューが表示されないことを確認" do
      get root_path
      expect(response.body).not_to include('id="account"')
    end

    it "ログイン後にaccountメニューが表示されることを確認" do
      log_in_as(user)
      get root_path
      expect(response.body).to include('id="account"')
    end
  end
end
