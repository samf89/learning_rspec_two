class ContactsController < ApplicationController
  before_action :set_contact, only: %i(show edit update destroy)
  before_action :set_contacts, only: :index
  before_action :set_new_contact, only: :new

  private
    def set_new_contact
      @contact = Contact.new
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_contacts
      @contacts = (letter = params[:letter]).present? ? Contact.by_letter(letter) : Contact.all
    end

end
