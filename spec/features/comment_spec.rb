require 'rails_helper'

feature 'user comments' do
  before(:all) do
    @user= FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
  end

  after(:all) do
    @goal.user.destroy
    @user.destroy
  end

  feature 'creating a comment on a user' do
    scenario 'user page has a comment input' do
      login(@user)
      visit user_url(@user.id)
      expect(page).to have_button 'Post Comment'
    end

    scenario 'user can comment on a user page' do
      login(@user)
      visit user_url(@user.id)
      fill_in 'body', with: 'Good luck'
      click_on 'Post Comment'
      expect(page).to have_content 'Good luck'
      expect(page).to have_content "—#{@user.username}"
    end
  end

  feature 'deleting a comment on a user' do
    scenario 'user can delete comments on their page' do
      comment = FactoryBot.create(:user_comment, user: @user)
      login(@user)
      visit user_url(@user.id)
      expect(page).to have_content comment.body
      click_on 'Delete Comment'
      expect(page).not_to have_content comment.body
    end

    scenario 'author can delete their comments' do
      comment = FactoryBot.create(:user_comment, author: @user)
      login(comment.user)
      visit user_url(comment.user)
      expect(page).to have_content comment.body
      click_on 'Delete Comment'
      expect(page).not_to have_content comment.body
    end
  end
end

feature 'goal comments' do
  before(:all) do
    @user= FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
  end

  after(:all) do
    @goal.user.destroy
    @user.destroy
  end

  feature 'creating a comment on a goal' do
    scenario 'goal page has comment input' do
      visit goal_url(@goal)
      expect(page).to have_button 'Post Comment'
    end

    scenario 'user can comment on a goal page' do
      login(@user)
      visit goal_url(@goal)
      fill_in 'body', with: 'Wow, nice goal.'
      click_on 'Post Comment'
      expect(page).to have_content 'Wow, nice goal.'
      expect(page).to have_content "—#{@user.username}"
    end
  end

  feature 'deleting a comment on a user' do
    scenario 'creator of goal can delete its comments' do
      comment = FactoryBot.create(:goal_comment, goal: @goal)
      login(comment.author)
      visit goal_url(@goal)
      expect(page).to have_content comment.body
      click_on 'Delete Comment'
      expect(page).not_to have_content comment.body
    end

    scenario 'author of comment can delete it' do
      comment = FactoryBot.create(:goal_comment, author: @user)
      login(@user)
      visit goal_url(comment.goal)
      expect(page).to have_content comment.body
      click_on 'Delete Comment'
      expect(page).not_to have_content comment.body
    end

    scenario 'random user cannot delete comment' do
      comment = FactoryBot.create(:goal_comment)
      login(@user)
      visit goal_url(comment.goal)
      expect(page).not_to have_button 'Delete Comment'
    end
  end
end