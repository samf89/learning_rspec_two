require 'rails_helper'

feature 'Logging in' do
  background do 
    # add in the set up details
  end

  scenario 'logging in as registered user' do
    user = create(:user)
    
    visit root_path
    click_link 'Log In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    
    expect(current_path).to eq user_path(user.id)
  end

  scenario 'logging in as unregistered user' do 
    visit root_path
    click_link 'Log In'

    fill_in 'Email', with: 'fake_email@email.com'
    fill_in 'Password', with: 'not a real password'
    click_button 'Log In'

    expect(current_path).to eq login_path
    expect(page).to have_content 'Incorrect Email/Password'
  end
end
