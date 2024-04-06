class Post < ApplicationRecord
  acts_as_taggable
  has_one_attached :post_image
  has_many :post_comments, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :admin, optional: true

  validate :user_or_admin

  enum status: { published: 0, draft: 1, unpublished: 2, }


  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_post.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search(keyword)
    if keyword.present?
      joins(:tags).where('tags.name LIKE ?', "%#{keyword}%")
    else
      all
    end
  end

  private

  def user_or_admin
    unless user.present? ^ admin.present?
      errors.add(:base, 'UserまたはAdminのどちらか一方のみ入力が必要です。')
    end
  end
end
