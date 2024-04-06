class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts
  has_many :post_comments, dependent: :destroy



  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

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

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  enum status: { active: 0, suspended: 1, withdrawn: 2 }

end
