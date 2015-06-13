FactoryGirl.define do

  factory :phone do
    association :contact
    phone_number { Faker::PhoneNumber.phone_number }

    factory :home_phone do 
      phone_type 'home'
    end

    factory :office_phone do
      phone_type 'office'
    end

    factory :work_phone do
      phone_type 'work'
    end

  end

end
