require 'rails_helper'

feature 'creating a new goal' do
  before(:all) { @user = FactoryBot.create(:user) }
  after(:all) { @user.destroy }

  scenario 'has a create page' do
    login(@user)
    visit new_goal_url
    expect(page).to have_content 'Create a new goal'
  end

  feature 'creates a goal' do
    before(:each) do
      login(@user)
      visit new_goal_url
      fill_in 'title', with: 'Step on 20 leaves'
      click_on 'Create Goal'
    end

    scenario 'redirects to User show page after signup' do
      expect(page).to have_content @user.username
      expect(page).to have_content 'Step on 20 leaves'
    end
  end

  feature 'editing a goal' do
    before(:all) do
      @user = FactoryBot.create(:user)
      @goal = FactoryBot.create(:goal, user: @user)
    end

    after(:all) do
      @user.destroy
      @goal.destroy
    end

    scenario 'has an edit page' do
      login(@user)
      visit edit_goal_url(@goal.id)
      expect(page).to have_content 'Edit goal'
    end
  
    feature 'updates a goal' do
      before(:each) do
        login(@user)
        visit edit_goal_url(@goal.id)
        fill_in 'title', with: 'Step on 30 leaves'
        click_on 'Update Goal'
      end
  
      scenario 'redirects to User show page after signup' do
        expect(page).to have_content @user.username
        expect(page).to have_content 'Step on 30 leaves'
      end
    end
  end

  feature 'showing a goal' do
    scenario 'shows a public goal to anyone' do
      goal = FactoryBot.create(:goal)
      visit goal_url(goal)
      expect(page).to have_content goal.title
    end

    scenario 'shows a private goal to goal\'s user' do
      user = FactoryBot.create(:user)
      goal = FactoryBot.create(:goal, user: user, secret: true)
      login(user)
      visit goal_url(goal)
      expect(page).to have_content goal.title
    end

    scenario 'does not show a private goal to anonymous' do
      goal = FactoryBot.create(:goal, secret: true)
      visit goal_url(goal)
      expect(page).not_to have_content goal.title
      expect(page).to have_content 'Login'
    end

    scenario 'does not show a private goal to a different logged in user' do
      user = FactoryBot.create(:user)
      goal = FactoryBot.create(:goal, secret: true)
      login(user)
      visit goal_url(goal)
      expect(page).not_to have_content goal.title
      expect(page).to have_content 'Welcome to your special account page'
    end
  end

  feature 'index of all public goals' do
    scenario 'shows all public goals' do
      goal1 = FactoryBot.create(:goal)
      goal2 = FactoryBot.create(:goal)
      goal3 = FactoryBot.create(:goal)
      goal4 = FactoryBot.create(:goal, secret: true)
      visit goals_url
      expect(page).to have_content goal1.title
      expect(page).to have_content goal2.title
      expect(page).to have_content goal3.title
      expect(page).not_to have_content goal4.title
    end
  end

  feature 'destroying goals' do
    scenario 'deletes a goal' do
      goal = FactoryBot.create(:goal)
      visit goals_url
      expect(page).to have_content goal.title
      goal.destroy
      visit goals_url
      expect(page).not_to have_content goal.title
    end
  end
end