require 'rails_helper'

describe SessionsController do 
  describe 'GET #new' do 
    it 'renders the new page' do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before :each do 
      @user = create(:user, email: 'fake@email.com', 
                            password: 'password',
                            password_confirmation: 'password' )
    end

    context 'with valid log in details' do 
      before :each do
        post :create, session:  { email: @user.email, password: @user.password } 
      end

      it 'assigns a user to @user' do 
        expect(assigns(:user)).to eq @user
      end

      it 'stored the user id in the session' do
        expect(session[:user_id]).to eq @user.id
      end

      it 'redirects to the users show page' do 
        expect(response).to redirect_to user_path(@user.id)
      end

    end

    context 'with invalid password' do 
      before :each do 
        post :create, session: { email: @user.email, password: 'wrong_password' }
      end

      it 'assigns a user to @user due to correct email address' do 
        expect(assigns(:user)).to eq @user
      end

      it 'doesnt store a user_id in the session' do
        expect(session[:user_id]).to eq nil
      end

      it 're-renders the :new page' do
        expect(response).to render_template :new
      end
    end

    context 'with unrecognized email' do
      before :each do 
        post :create, session: { email: 'wrong@email.com', password: @user.password }
      end

      it 'doesnt log in the user' do 
        expect(assigns(:user)).to eq nil
      end

      it 'doesnt store a user_id in the session' do
        expect(session[:user_id]).to eq nil
      end

      it 're-renders the :new page' do
        expect(response).to render_template :new
      end
    end

  end

  describe 'DELETE #destroy' do 
    before :each do
      delete :destroy
    end

    it 'empties the session of user_id' do
      expect(session[:user_id]).to eq nil
    end

    it 'redirects to the root page' do
      expect(response).to redirect_to root_path
    end
  end
end
