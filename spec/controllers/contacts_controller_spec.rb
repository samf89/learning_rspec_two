require 'rails_helper'

describe ContactsController do

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

end
