# frozen_string_literal: true

class AddHubspotIdToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :hubspot_id, :integer
  end
end
