# spec/helpers/sessions_helper_spec.rb
require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  # --------------------------------------------------
  # Fixtures / FactoryBot などでテスト用ユーザーを用意
  # --------------------------------------------------
  let(:user) { create(:user) }  # fixtures を使う場合は: users(:michael)

  # --------------------------------------------------
  # remember(user) を呼び、session は空のまま
  # --------------------------------------------------
  before { helper.remember(user) }

  describe "#current_user" do
    context "session が nil のとき" do
      it "ユーザーを返し logged_in? が true になる" do
        expect(helper.current_user).to eq user
        expect(helper.logged_in?).to be true
      end
    end

    context "remember_digest が不正なとき" do
      it "current_user は nil を返す" do
        user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(helper.current_user).to be_nil
      end
    end
  end
end
