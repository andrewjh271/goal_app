require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Create an account'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      create_user('thedirgni', 'hobbit')
      expect(page).to have_content 'thedirgni'
    end
  end
end

feature 'logging in' do
  before(:each) { create_user('cheetah', 'jungle') }
  scenario 'shows username on the homepage after login' do
    visit new_session_url
    fill_in 'username', with: 'cheetah'
    fill_in 'password', with: 'jungle'
    find('#submit-form').click
    # click_on 'Login'
    # two submit forms on page (one in header); created custom id to target correct one
    expect(page).to have_content 'cheetah'
  end
end

feature 'logging out' do
  before(:each) { create_user('cheetah', 'jungle') }
  scenario 'begins with a logged in state' do
    expect(page).to have_content 'cheetah'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_on 'Logout'
    expect(page).not_to have_content 'Goals:'
  end
end