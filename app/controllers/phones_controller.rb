class PhonesController < ApplicationController
  before_action :set_phone, only: %i(show)
  before_action :set_contact, only: %i(show)

  private
    def set_phone
      @phone = Phone.find(params[:id])
    end

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
end
