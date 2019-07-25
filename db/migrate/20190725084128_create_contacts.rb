# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
    add_index :contacts, :email, unique: true
  end
end
