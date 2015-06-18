require 'rails_helper'

describe UsersController, type: :controller do 

  describe 'GET #new' do
    before :each do
      get :new
    end

    it 'assigns a new user to @user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders the :new page' do 
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do 
    context 'valid signup' do
      it 'saves a new user in the database' do 
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by 1
      end

      it 'redirects to the users show page' do 
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end

      it 'logs the user into the website' do
        post :create, user: attributes_for(:user)
        user = assigns(:user)
        expect(session[:user_id]).to eq user.id
      end
    end

    context 'invalid signup' do 
      it 'doesnt save a new user in the database' do
        expect {
          post :create, user: attributes_for(:invalid_user)
        }.not_to change(User, :count)
      end

      it 're renders the new page' do 
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

end
