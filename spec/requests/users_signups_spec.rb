require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "POST /users_signups" do
    it "入力されたユーザー情報が正しくないとき、DBに登録しない" do
      get signup_path
      expect {
        post users_path, params: {
          user: {
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("form")
      expect(response.body).to include('class="form-control"')
    end
  end

  describe "POST /users_signups" do
    it "正しくログインできるか確認" do
      get signup_path
      expect {
        post users_path, params: {
          user: {
            name: "Exampleuser",
            email: "user@example.com",
            password: "password12",
            password_confirmation: "password12"
          }
        }
      }.to change(User, :count).by(1)

      follow_redirect!
      expect(response.body).to include("Exampleuser")
      expect(flash[:success]).to eq("ユーザー登録が完了しました")
      
      # ログイン後の表示になっていることを確認（'と"の使い分けに注意）
      expect(response.body).to include('id="account"')
    end
  end
end
