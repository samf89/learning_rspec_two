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
    fill_in 'Email', with: 'new_user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password Confirmation', with: '123456'
    click_button 'Create User'

    new_user = assigns(:user)
    expect(current_path).to eq user_path(user.id)
  end

  scenario 'Unsuccessfully creating a new user' 
end
