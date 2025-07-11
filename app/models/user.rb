class User < ApplicationRecord
    attr_accessor :remember_token
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 12 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email,
        presence: true,
        length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 9 }, allow_nil: true

    # 渡された文字列のハッシュ値を返す
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続的セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # ブラウザから渡されたトークンがDB内のdigestと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end
end
