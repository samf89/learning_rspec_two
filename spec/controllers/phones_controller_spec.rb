require 'rails_helper'

describe PhonesController do 

  describe 'GET #show' do
    before :each do
      @contact = create(:contact)
      @phone   = create(:home_phone, contact: @contact)
      get :show, id: @phone.id, contact_id: @contact.id
    end

    it 'assigns a contact and a phone' do
      expect(assigns(:phone)).to eq @phone
      expect(assigns(:contact)).to eq @contact
    end

    it 'renders the show page for the phone' do
      expect(response).to render_template :show
    end

  end

end
