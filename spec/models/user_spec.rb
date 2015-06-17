require 'rails_helper'

describe User do

  before :each do 
    @user = build(:user)
  end

  it 'is valid with a username, firstname, lastname and email, and password' do
    expect(@user).to be_valid
  end

  it 'is invalid without a username' do
    @user.username = nil
    expect(@user).not_to be_valid
    expect(@user.errors[:username]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    @user.email = nil
    expect(@user).not_to be_valid
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a firstname' do
    @user.firstname = nil
    expect(@user).not_to be_valid
    expect(@user.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without a lastname' do
    @user.lastname = nil
    expect(@user).not_to be_valid
    expect(@user.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid with duplicate email' do
    email = 'fake@email.com'
    other_user = create(:user, email: email)
    @user.email = email
    expect(@user).not_to be_valid
    expect(@user.errors[:email]).to include("has already been taken")
  end

  it 'is invalid with duplicate username' do
    username = 'blazeit420'
    other_user = create(:user, username: username)
    @user.username = username
    expect(@user).not_to be_valid
    expect(@user.errors[:username]).to include("has already been taken")
  end

  it 'is invalid if passwords dont match' do
    @user.password = '123456'
    @user.password_confirmation = '89898989'
    expect(@user).not_to be_valid
    expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
  end

end
