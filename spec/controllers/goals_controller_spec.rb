require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  before(:all) { @user = User.create!(username: 'cheetah', password: 'jungle') }
  after(:all) { @user.destroy }

  describe 'GET #new' do
    it 'renders the new template' do
      login_user(@user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'requires current_user' do
        post :create, params: { goal: { title: 'Eat a raspberry' } }
        expect(response).to redirect_to(new_session_url)
      end

      it 'validates the presence of title' do
        login_user(@user)
        post :create, params: { goal: { nonsense: true } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Title can\'t be blank'])
      end
    end
    context 'with valid params' do
      it 'redirects to user show page on success' do
        login_user(@user)
        post :create, params: { goal: { title: 'Eat a raspberry' } }
        expect(response).to redirect_to(user_url)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      login_user(@user)
      goal = FactoryBot.create(:goal, user_id: @user.id)
      get :edit, params: { id: goal.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #update' do
    before(:each) { @goal = FactoryBot.create(:goal, user_id: @user.id) }

    context 'with invalid params' do
      it 'requires current_user' do
        post :update, params: { goal: { title: 'Eat a raspberry' }, id: @goal.id }
        expect(response).to redirect_to(new_session_url)
      end

      it 'validates the presence of title' do
        login_user(@user)
        post :update, params: { goal: { title: nil }, id: @goal.id }
        expect(response).to render_template(:edit)
        expect(flash[:errors]).to eq(['Title can\'t be blank'])
      end
    end

    context 'with valid params' do
      it 'redirects to user show page on success' do
        login_user(@user)
        post :update, params: { goal: { title: 'Eat a raspberry' }, id: @goal.id }
        expect(response).to redirect_to(user_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { @goal = FactoryBot.create(:goal, user_id: @user.id) }

    it 'deletes a goal and redirects to user\'s show page' do
      login_user(@user)
      delete :destroy, params: { id: @goal.id }
      expect(response).to redirect_to(user_url)
      expect(Goal.find_by(id: @goal.id)).to be nil
    end
  end

end
