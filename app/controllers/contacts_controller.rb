class ContactsController < ApplicationController
  before_action :set_contact, only: %i(show edit update destroy hide)
  before_action :set_contacts, only: :index
  before_action :set_new_contact, only: :new

  def create
    @contact = Contact.new(params_for_contact)
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render :new
    end
  end

  def update
    if @contact.update_attributes(params_for_contact)
      redirect_to contact_path(@contact)
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path
  end

  def hide
    if @contact.update_attributes(hidden: true)
      redirect_to contacts_path
    else 
      render :show
    end
  end

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

    def params_for_contact
      params.require(:contact).permit(:firstname, 
                                      :lastname,
                                      :email,
                                      phones_attributes: [:phone_type, :phone_number] )
    end

end
