class Notice < ApplicationRecord
  belongs_to :user
  belongs_to :origin, class_name: "Notice", optional: true
  has_many :similars, class_name: "Notice", dependent: :destroy

  enum message_type: %i[first_login get_follower]

  validates :message_type, inclusion: { in: Notice.message_types.keys }

  scope :made_within_5_minutes, ->(user_id) {
    where(user_id: user_id).
      where(created_at: (Time.now - 5.minutes)...(Time.now)).
      where(notice_id: nil).
      order(created_at: :desc)
  }
  scope :show_notices, ->(user_id) { where(user_id: user_id).where(notice_id: nil) }

  def self.get_follower_notice!(follower_user, follow_user)
    create!(
      user: follower_user,
      message_type: :get_follower,
      notice_id: Notice.made_within_5_minutes(follower_user.id).first&.id,
      optional: { follow_user_id: follow_user.id }
    )
  end

  def self.first_login_notice!(user)
    create!(
      user: user,
      message_type: :first_login,
      notice_id: nil
    )
  end

  def follower_name
    User.find_by(id: optional["follow_user_id"])&.name
  end
end
