# frozen_string_literal: true

module Api
  class ContactsController < BaseController
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render @contact, status: :created
      else
        render_bad_request @contact.errors
      end
    end

    private

    def contact_params
      params.require(:contact).permit(:email, :lastname, :firstname)
    end
  end
end
