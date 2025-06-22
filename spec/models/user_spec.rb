require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com")
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
end
