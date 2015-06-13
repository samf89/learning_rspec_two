require 'rails_helper'

describe Contact do 
  it 'is valid with a firstname, lastname and email' do
    expect(create(:contact)).to be_valid
  end

  it 'is invalid wihtout a firstname' do
    contact = build(:contact, firstname: nil)
    expect(contact).not_to be_valid
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without a lastname' do
    contact = build(:contact, lastname: nil)
    expect(contact).not_to be_valid
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    contact = build(:contact, email: nil)
    expect(contact).not_to be_valid
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    create(:contact, email: 'fake@email.com')
    contact = build(:contact, email: 'fake@email.com')
    expect(contact).not_to be_valid
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it 'returns the contacts full name as a string' do
    contact = build(:contact, firstname: 'Jack', lastname: 'Burton')
    expect(contact.full_name).to eq 'Jack Burton'
  end

  describe 'filter by last name letter' do
    before :each do
    end

    context 'matching letters' do 
      it 'returns a sorted array of results that match' 
    end

    context 'non-matching letters' do 
      it 'omits results that do not match'
    end
  end

end
