FactoryGirl.define do 
  factory :user do 
    username { Faker::Internet.user_name } 
    firstname { Faker::Name.first_name } 
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'password' 
    password_confirmation 'password' 

    factory :admin_user do
      admin true
    end

    factory :invalid_user do 
      password 'password'
      password_confirmation 'not_password'
    end
  end
end
