require 'rails_helper'

feature 'About modal on home page' do 
  scenario 'toggles display of the about modal', js: true do  

    visit root_path
    expect(page).not_to have_content 'about partial'

    click_link 'About Modal'

    expect(page).to have_content 'about partial'

    click_link 'Close'

    expect(page).not_to have_content 'about partial'
  end
end
