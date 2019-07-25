# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  validates :lastname, presence: true, length: { minimum: 2 }
  validates :firstname, presence: true, length: { minimum: 2 }

  after_create :create_on_hubspot

  def email=(value)
    super(value.downcase)
  end

  def lastname=(value)
    super(value.downcase)
  end

  def firstname=(value)
    super(value.downcase)
  end

  private

  def create_on_hubspot
    CreateHubspotContactJob.perform_later self
  end
end
