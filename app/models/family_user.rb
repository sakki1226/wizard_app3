class FamilyUser
  include ActiveModel::Model
  attr_accessor :name, :user1, :user2

  validates :name, presence: true

  def save
    family = Family.create(name: name)
    user1_info = user1
    user2_info = user2

    user1 = family.users.build(nickname: user1_info[:nickname], email: user1_info[:email], password: user1_info[:password], password_confirmation: user1_info[:password_confirmation])
    user2 = family.users.build(nickname: user2_info[:nickname], email: user2_info[:email], password: user2_info[:password], password_confirmation: user2_info[:password_confirmation])

    if user1.save && user2.save
      return true
    else
      errors.add(:base, "Users could not be saved")
      return false
    end
  end
end

