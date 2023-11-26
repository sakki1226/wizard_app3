class FamilyUser
  include ActiveModel::Model
  attr_accessor :name, :user1, :user2, :nickname

  validates :name, presence: true
  validate :validate_user1, if: :user1_present?
  validate :validate_user2, if: :user2_present?

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

  def validate_user1
    return unless user1.present?

    errors.add(:nickname, "(ユーザー1)を入力してください") unless user1["nickname"].present?
    errors.add(:email, "(ユーザー1)を入力してください") unless user1["email"].present?
    errors.add(:password, "(ユーザー1)を入力してください") unless user1["password"].present?
    errors.add(:password_confirmation, "(ユーザー1)を入力してください") unless user1["password_confirmation"].present?
    errors.add(:password_confirmation, "(ユーザー1)が一致しません") if user1["password"] != user1["password_confirmation"]
    
  end

  def validate_user2
    return unless user2.present?

    # errors.add(:user2, "can't be blank user2")  
    errors.add(:nickname, "(ユーザー2)を入力してください") unless user2["nickname"].present?
    errors.add(:email, "(ユーザー2)を入力してください") unless user2["email"].present?
    errors.add(:password, "(ユーザー2)を入力してください") unless user2["password"].present?
    errors.add(:password_confirmation, "(ユーザー2)を入力してください") unless user2["password_confirmation"].present?
    errors.add(:password_confirmation, "(ユーザー2)が一致しません") if user2["password"] != user2["password_confirmation"]
    #Add more validations for user2 if needed
  end

  # Add more validations for user2 if needed
end
