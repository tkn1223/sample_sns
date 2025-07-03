require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe "POST #create（remember me = '1'）" do
    it "Cookie と @user.remember_token が一致する" do
      post :create, params: {
        session: {
          email:       user.email,
          password:    user.password,
          remember_me: "1"
        }
      }

      # assigns(:user).remember_token は create アクション内でセットされた仮想属性
      expect(cookies[:remember_token]).to eq assigns(:user).remember_token
      expect(cookies[:remember_token]).not_to be_blank
    end
  end

  describe "POST #create（remember me = '0'）" do
    it "remember_token Cookie が空である" do
      # 1回目: remember_me='1' で Cookie を残す
      post :create, params: {
        session: { email: user.email, password: user.password, remember_me: "1" }
      }
      delete :destroy

      # 2回目: remember_me='0' で Cookie を削除
      post :create, params: {
        session: { email: user.email, password: user.password, remember_me: "0" }
      }

      expect(cookies[:remember_token]).to be_blank
    end
  end
end
