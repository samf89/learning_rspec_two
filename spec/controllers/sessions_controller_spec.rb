require 'rails_helper'

describe SessionsController do 
  describe 'GET #new' do 
    it 'renders the new page' do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid log in details' do 
      before :each do
        @user = create(:user, email: 'fake@email.com', 
                             password: 'password',
                             password_confirmation: 'password' )
      end

      it 'assigns a user to @user' do 
        post :create, session:  { email: @user.email, password: @user.password } 
        expect(assigns(:user)).to eq @user
      end

      it 'stored the user id in the session' 

      it 'redirects to the users show page'

    end

    context 'with invalid log in details' do 
      it 'doesnt log in the user'

      it 'doesnt store a user_id in the session'

      it 're-renders the :new page'
    end
  end

  describe 'DELETE #destroy' do 
  end
end
