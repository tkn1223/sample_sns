# ブラウザ担当のテストを記述する。永続化cookiesの確認もここで行う

# spec/system/users_logins_spec.rb
require "rails_helper"

RSpec.describe "UsersLogins (remember me)", type: :system do
  let(:user) { create(:user) }

  it "ログイン状態を保持する場合はremember_tokenがセットされる" do
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    check "ログイン状態を保持しますか？"
    click_button "ログイン"
    expect(get_me_the_cookie("remember_token")[:value]).not_to be_blank
  end

  it "ログイン状態を保持しない場合はremember_tokenがない" do
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button "ログイン"
    expect(get_me_the_cookie("remember_token")).to be_nil
  end
end
