FactoryBot.define do
  factory :family_user do
    name { Faker::Name.unique.name }
    user1 {
      {
        nickname: Faker::Name.unique.first_name,
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password(min_length: 8),
        password_confirmation: Faker::Internet.password(min_length: 8)
      }
    }
    user2 {
      {
        nickname: Faker::Name.unique.first_name,
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password(min_length: 8),
        password_confirmation: Faker::Internet.password(min_length: 8)
      }
    }
  end
end