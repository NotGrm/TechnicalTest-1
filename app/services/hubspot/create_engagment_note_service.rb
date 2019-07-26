# frozen_string_literal: true

module Hubspot
  class CreateEngagmentNoteService
    attr_reader :contact, :body

    def initialize(contact, body)
      @contact = contact
      @body = body
    end

    def execute
      Hubspot::EngagementNote.create!(contact.hubspot_id, body)
    rescue Hubspot::RequestError => e
      errors.push e.response.body
    end

    def success?
      errors.empty?
    end

    def errors
      @errors ||= []
    end
  end
end
