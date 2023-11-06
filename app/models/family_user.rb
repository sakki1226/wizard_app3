class FamilyUser
  include ActiveModel::Model
  attr_accessor :name, :nickname, :email, :encrypted_password, :family_id

  validates :name, :nickname, :email, :encrypted_password, :family_id, presence: true

  def save
    family = Family.create(name: name)
    user = family.users.build(nickname: nickname, email: email, password: encrypted_password)

    if user.save
      return true
    else
      errors.add(:base, "User could not be saved")
      return false
    end
  end
end
