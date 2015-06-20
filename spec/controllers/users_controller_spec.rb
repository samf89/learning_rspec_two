require 'rails_helper'

describe UsersController, type: :controller do 
  describe 'non admin access' do 
    before :each do 
      @user = create(:user)
      session[:user_id] = @user.id
    end

    describe 'GET #index' do 
      it 'collects users into @users' do
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [@user, user]
      end

      it 'renders the index template' do 
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do 
      it 'doesnt allow user to create a new user' do 
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe 'POST #create' do 
      it 'denies access to the create method' do 
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'admin access' do 
    before :each do 
      @admin_user = create(:admin_user)
      session[:user_id] = @admin_user.id
    end

    describe 'GET #index' do 
      it 'assigns a collection of users to @users' do 
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [user, @admin_user]
      end

      it 'renders the :index template' do 
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do 
      before :each do 
        get :new
      end

      it 'assigns a new user to @user' do 
        expect(assigns(:user)).to be_a_new User
      end

      it 'renders the :new template' do 
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do  
      context 'with valid attributes' do
        it 'adds a new user to the database' do
          expect {
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by 1
        end

        it 'renders the new users show page' do 
          post :create, user: attributes_for(:user)
          user = assigns(:user)
          expect(response).to redirect_to user_path(user.id)
        end
      end

      context 'with invalid attributes' do 
        it 'doesnt add a new user to the database' do
          expect {
            post :create, user: attributes_for(:invalid_user)
          }.not_to change(User, :count)
        end

        it 're-renders the new page' do
          post :create, user: attributes_for(:invalid_user)
          expect(response).to render_template :new
        end
      end
    end
  end

end
