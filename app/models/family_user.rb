class FamilyUser
  include ActiveModel::Model
  attr_accessor :name, :nickname, :email, :encrypted_password, :family_id

  validates :name, :nickname, :email, :encrypted_password, :family_id, presence: true

  def save
  end
end
