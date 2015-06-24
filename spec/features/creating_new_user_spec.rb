require 'rails_helper'

feature 'Creating new user' do 
  background do 
    @admin = create(:admin_user)
    log_in_as @admin
  end

  scenario 'Successfully creating a new user' do 
    click_link 'Users'
    expect(current_path).to eq users_path
    
    click_link 'Add New User'
    fill_in 'Username', with: 'this is a username'
    fill_in 'Firstname', with: 'Bob'
    fill_in 'Lastname', with: 'Loblaw'
    fill_in 'Email', with: 'new_user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Create User'

    expect(page).to have_content 'this is a username'
  end

  scenario 'Unsuccessfully creating a new user' do
    click_link 'Users'
    expect(current_path).to eq users_path

    click_link 'Add New User'
    fill_in 'Username', with: 'this is a username'
    fill_in 'Firstname', with: nil
    fill_in 'Lastname', with: 'Loblaw'
    fill_in 'Email', with: 'new_user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '654321'
    click_button 'Create User'

    expect(page).to have_content "Firstname can't be blank"
  end

end
