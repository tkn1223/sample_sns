require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "POST /users_signups" do
    it "入力されたユーザー情報が正しくないとき、DBに登録しない" do
      get signup_path
      expect{
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
end
