require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of the user\'s password' do
        post :create, params: { user: { username: 'jen' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).not_to be nil
      end

      it 'validates the presence of the user\'s email' do
        post :create, params: { user: { password: 'thepassword' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Username can\'t be blank'])
      end

      it 'validates that the password is at least 6 characters' do
        post :create, params: { user: { username: 'jen', password: '12345'} }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Password is too short (minimum is 6 characters)'])
      end
    end

    context 'with valid params' do
      it 'redirects user to show page on success' do
        post :create, params: { user: { username: 'jen', password: '123456'} }
        expect(response).to redirect_to(user_url(User.find_by(username: 'jen')))
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      user = User.create!(username: 'parrot', password: 'jungle')
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

end
