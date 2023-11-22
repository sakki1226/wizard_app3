FactoryBot.define do
  factory :family_user do
    sequence(:name) { |n| "Family#{n}" }

    trait :with_user1 do
      after(:build) do |family_user|
        family_user.user1 = build(:user)
      end
    end

    trait :with_user2 do
      after(:build) do |family_user|
        family_user.user2 = build(:user)
      end
    end
  end

  factory :user do
    sequence(:nickname) { |n| "User#{n}" }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { |attrs| attrs[:password] }
  end
end