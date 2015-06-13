FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    email     { Faker::Internet.email }

    factory :invalid_contact do 
      firstname nil
    end
  end
end
