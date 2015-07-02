require 'rails_helper'

describe ContactsController do

  shared_examples 'public access to contacts' do 
    let(:contact) { create(:contact, firstname: 'Lawrence', lastname: 'Smith') }

    describe 'GET #index' do 
      before :each do 
        get :index 
      end

      it 'populates an array of contacts' do
        expect(assigns(:contacts)).to match_array [contact]
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do 
      before :each do 
        get :show, id: contact.id
      end

      it 'assigns the requested contact to @contact' do
        expect(assigns(:contact)).to eq contact
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'full access to contacts' do 
    describe 'GET #new' do 
      before :each do 
        get :new
      end

      it 'assigns a new contact to @contact' do 
        expect(assigns(:contact)).to be_a_new Contact
      end

      it 'renders the :new template' do 
        expect(response).to render_template :new
      end

    end

    describe 'GET #edit' do 
      let(:contact) { create(:contact) }

      before :each do 
        get :edit, id: contact.id
      end

      it 'assigns the correct contact to @contact' do 
        expect(assigns(:contact)).to eq contact
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
      let!(:contact) { create(:contact) } #exclamation point forces this to be ran before tests

      it 'deletes the contact' do 
        expect {
          delete :destroy, id: contact.id
        }.to change(Contact, :count).by -1
      end

      it 'redirects to the contact index page' do
        delete :destroy, id: contact.id
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

  describe 'accessing site as admin' do
    before :each do 
      set_user_session create(:admin_user)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'

  end
  
  describe 'accessing as regular user' do
    before :each do 
      set_user_session create(:user)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'

  end

  describe 'accessing as a guest user' do 
    
    it_behaves_like 'public access to contacts'

    describe 'GET #new' do 
      it 'requires a login' do 
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do 
      it 'requires a login' do 
        contact = create(:contact)
        get :edit, id: contact.id
        expect(response).to require_login
      end
    end

    describe 'POST #create' do 
      it 'requires a login' do 
        post :create, contact: attributes_for(:contact)
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do 
      it 'requires a login' do 
        contact = create(:contact)
        put :update, id: contact.id, contact: attributes_for(:contact)
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do 
      it 'requires a login' do 
        delete :destroy, id: create(:contact).id
        expect(response).to require_login
      end
    end

  end

end
