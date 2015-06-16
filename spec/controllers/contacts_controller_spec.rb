require 'rails_helper'

describe ContactsController do

  describe 'accessing site as admin' do
    before :each do 
      user = create(:admin)
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      before :each do 
        @smith   = create(:contact, lastname: 'smith')
        @johnson = create(:contact, lastname: 'johnson')
        @jones   = create(:contact, lastname: 'jones')
      end

      context 'with params[:letter]' do
        before :each do 
          get :index, letter: 's'
        end

        it 'populates an array of contacts starting with the passed in letter' do
          expect(assigns(:contacts)).to eq [@smith]
        end

        it 'renders the index view' do
          expect(response).to render_template :index
        end
      end

      context 'without params[:letter]' do
        before :each do 
          get :index
        end

        it 'populates an array containing all contacts' do
          expect(assigns(:contacts)).to match_array [@smith, @johnson, @jones]
        end

        it 'renders the index view' do 
          expect(response).to render_template :index
        end
      end
    end

    describe 'GET #show' do
      before :each do 
        @contact = create(:contact)
        get :show, id: @contact.id
      end

      it 'assigns a contact to @contact' do 
        expect(assigns(:contact)).to eq @contact
      end

      it 'renders the show view' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do 
      before :each do 
        get :new
      end

      it 'assigns a new contact to @contact' do 
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it 'renders the new view' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do 
        @contact = create(:contact)
        get :edit, id: @contact.id
      end

      it 'assigns the correct contact to @contact' do 
        expect(assigns(:contact)).to eq @contact
      end

      it 'renders the edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      before :each do 
        @phones = [
          attributes_for(:work_phone),
          attributes_for(:office_phone),
          attributes_for(:home_phone)
        ]
      end

      context 'with valid attributes' do 
        it 'saves the new contact in the database' do
          expect {
            post :create, contact: attributes_for(:contact, phones_attributes: @phones)
          }.to change(Contact, :count).by 1
        end

        it 'redirects to the show page' do 
          post :create, contact: attributes_for(:contact, phones_attributes: @phones)
          expect(response).to redirect_to contact_path(assigns[:contact])
        end
      end

      context 'without valid attributes' do
        it 'does not save the new contact in the database' do 
          expect {
            post :create, contact: attributes_for(:invalid_contact)
          }.not_to change(Contact, :count)
        end

        it 're-renders the new page' do
          post :create, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do 
      before :each do
        @contact = create(:contact, firstname: 'Lawrence', lastname: 'Smith')
      end
      
      context 'with valid attributes' do
        it 'changes @contacts attributes in the database' do 
          patch :update, id: @contact.id, 
                         contact: attributes_for(:contact,
                                                 firstname: 'Larry',
                                                 lastname: 'Smith')
          @contact.reload
          expect(@contact.firstname).to eq 'Larry'
          expect(@contact.lastname).to eq 'Smith'
        end

        it 'redirects to the contacts show page' do 
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(response).to redirect_to contact_path(@contact.id)
        end
      end

      context 'without valid attributes' do
        it 'does not update the contact in the database' do
          patch :update, id: @contact, 
                         contact: attributes_for(:contact,
                                                 firstname: 'Larry',
                                                 lastname: nil)
          @contact.reload
          expect(@contact.firstname).not_to eq 'Larry'
          expect(@contact.lastname).to eq 'Smith'
        end

        it 're renders the edit page' do
          patch :update, id: @contact, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      before :each do 
        @contact = create(:contact)
      end

      it 'deletes the contact' do 
        expect {
          delete :destroy, id: @contact.id
        }.to change(Contact, :count).by -1
      end

      it 'redirects to the contact index page' do
        delete :destroy, id: @contact.id
        expect(response).to redirect_to contacts_path
      end
    end

    describe 'PATCH hide' do
      before :each do 
        @contact = create(:contact)
        patch :hide, id: @contact.id
      end
      
      context 'successfully hide contact' do 
        it 'marks the contact as hidden' do
          expect(@contact.reload.hidden).to eq true
        end

        it 'redirects to the contacts#index page' do
          expect(response).to redirect_to contacts_path
        end
      end

    end
  end
  
  describe 'accessing as regular user' do
    # for now these are the same as above so no point dusplacting it
  end

  describe 'accessing as a guest user' do 
    # index and show examples are the same as admin and user

    describe 'GET #new' do 
      it 'requires a login' do 
        get :new
        expect(response).to redirect_to login_path
      end
    end

  end

end
