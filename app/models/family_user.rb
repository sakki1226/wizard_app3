class FamilyUser
  include ActiveModel::Model
  attr_accessor :name, :user1, :user2, :nickname, :email, :password, :password_confirmation

  validates :name, presence: true

  with_options if: :user1_present? do |user1|
    user1.validates :nickname, :email, :password, :password_confirmation, presence: true
  end

  with_options if: :user2_present? do |user2|
    user2.validates :nickname, :email, :password, :password_confirmation, presence: true
  end

  def save
    family = Family.create(name: name)
    user1_info = user1
    user2_info = user2

    user1 = family.users.build(
      nickname: user1_info[:nickname],
      email: user1_info[:email],
      password: user1_info[:password],
      password_confirmation: user1_info[:password_confirmation]
    )

    user2 = family.users.build(
      nickname: user2_info[:nickname],
      email: user2_info[:email],
      password: user2_info[:password],
      password_confirmation: user2_info[:password_confirmation]
    )

    if user1.save && user2.save
      true
    else
      errors.add(:base, "Users could not be saved")
      false
    end
  end

  private

  def user1_present?
    user1.present?
  end

  def user2_present?
    user2.present?
  end
end

