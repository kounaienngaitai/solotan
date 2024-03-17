class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "guest"
      user.first_name = "01"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "ゼロイチ"
      user.handle_name = "ゲストユーザー"
      user.birth_date = "19930101"
      user.postal_code = "1112222"
      user.address = "XX県XX市XX町"
      user.telephone_number = "09011111111"
      user.status = "0"

    end
  end

end
