require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  # factorise>users.rbに沿ってユーザーを1人追加
  let(:user) { FactoryBot.create(:user) }

  describe "GET /users/:id/edit" do
    it "無効な値では更新できない（レンダリングされる）ことを確認" do
      log_in_as(user, password: "pass00word")
      get edit_user_path(user)
      expect(response).to render_template(:edit)

      patch user_path(user), params: {
        user: {
          name: "",
          email: "foo@invalid",
          password: "foo",
          password_confirmation: "foo"
        }
      }
      
      expect(response).to render_template(:edit)
      expect(response.body).to include("error")
      expect(response.body).to include("The form contains 3 errors.")
    end

    it "情報の更新が正しくされることを確認" do
      new_name = "test10"
      new_email = "test@bar.com"

      log_in_as(user, password: "pass00word")
      get edit_user_path(user)
      expect(response).to render_template(:edit)

      # 有効なアカウント情報を入力
      patch user_path(user), params: {
        user: {
          name: new_name,
          email: new_email,
          password: "123456789",
          password_confirmation: "123456789"
        }
      }
      
      expect(flash).not_to be_empty
      expect(response).to redirect_to(user)
      user.reload
      expect(user.name).to eq(new_name)
      expect(user.email).to eq(new_email)
    end
  end
end
