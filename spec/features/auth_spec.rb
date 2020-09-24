require 'spec_helper'
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
    click_on 'Login'
    expect(page).to have_content 'cheetah'
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'
end