require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobarbaz", password_confirmation: "foobarbaz")
  end

  it "ユーザー情報がバリデーションを満たしているか確認" do
    expect(@user).to be_valid
  end

  it "nameの存在性を確認" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  it "emailの存在性を確認" do
    @user.email = ""
    expect(@user).not_to be_valid
  end

  it "nameの文字数を確認" do
    @user.name = "a" * 13
    expect(@user).not_to be_valid
  end

  it "emailの文字数を確認" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "emailのよくあるダメパターンを確認" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_addresses|
      @user.email = invalid_addresses
      expect(@user).not_to be_valid
    end
  end

  it "emailの重複を確認" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user).not_to be_valid
  end

  it "emailは小文字で保存される" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(@user.reload.email).to eq mixed_case_email.downcase
  end

  it "パスワードがから出ないことを確認" do
    @user.password = @user.password_confirmation = "" * 8
    expect(@user).not_to be_valid
  end

  it "パスワードが5文字以上あることを確認" do
    @user.password = @user.password_confirmation = "a" * 8
    expect(@user).not_to be_valid
  end
end
