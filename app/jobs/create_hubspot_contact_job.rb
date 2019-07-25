class CreateHubspotContactJob < ApplicationJob
  queue_as :default

  def perform(contact)
    create_contact_service = Hubspot::CreateContactService.new(contact)

    create_contact_service.execute

    if create_contact_service.success?
      contact.update(hubspot_id: create_contact_service.hubspot_contact_id)

      Hubspot::CreateEngagmentNoteService.new(contact, 'Created by Jeremy BERTRAND').execute
    end
  end
end
