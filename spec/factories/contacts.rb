FactoryGirl.define do
  factory :contact do
    association :user
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    email     { Faker::Internet.email }

    after(:build) do |contact|
      %i(home_phone office_phone work_phone).each do |phone_type|
        contact.phones << FactoryGirl.build(:phone, phone_type: phone_type, contact: contact)
      end
    end

    factory :invalid_contact do 
      firstname nil
    end

    factory :hidden_contact do
      hidden true
    end
  end
end
