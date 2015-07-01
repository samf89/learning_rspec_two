require 'rails_helper'

feature 'User management' do 
  background do
    @admin = create(:admin_user)
    @user  = create(:user, username: 'fake_user')
    log_in_as @admin
  end

  scenario 'deleting a user', js: true do 
    click_link 'Users'
    expect(current_path).to eq users_path

    expect(page).to have_content 'fake_user'

    save_and_open_page
    find_button("#delete-user-#{@user.id}").click

    expect(page).not_to have_content 'fake_user'
  end

end
