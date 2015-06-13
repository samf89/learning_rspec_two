require 'rails_helper'

describe Phone do
  it 'is valid with a valid contact, phone number and phone type' do
    expect(build(:home_phone)).to be_valid
  end

  it 'is invalid without a phone type' do
    phone = build(:phone)
    expect(phone).not_to be_valid
    expect(phone.errors[:phone_type]).to include("can't be blank")
  end
  
  it 'is invalid with a phone number' do
    phone = build(:phone, phone_number: nil)
    expect(phone).not_to be_valid
    expect(phone.errors[:phone_number]).to include("can't be blank")
  end

  it 'does not allow duplicate phone numbers per contact' do
    phone_number = '123456789'
    contact      = create(:contact)
    work_phone   = create(:work_phone, contact: contact, phone_number: phone_number)
    office_phone = build(:office_phone, contact: contact, phone_number: phone_number)
    expect(office_phone).not_to be_valid
    expect(office_phone.errors[:phone_number]).to include('has already been taken')
  end

  it 'does allow phone numbers to be shared amongst contacts' do 
    phone_number = '123456789'
    create(:home_phone, phone_number: phone_number)
    expect(build(:home_phone, phone_number: phone_number)).to be_valid
  end
end
