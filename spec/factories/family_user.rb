FactoryBot.define do
  factory :family_user do
    name { '立花' }

    user1 do
      {
        "nickname"=> 'はなこ',
        "email"=>  'sample@sample',
        "password"=>  '00000000',
        "password_confirmation"=>  '00000000'
      }
    end

    user2 do
      {
        "nickname"=>  'たろう',
        "email"=>  'sample1@sample',
        "password"=>  '99999999',
        "password_confirmation"=>  '99999999'
      }
    end
  end
end