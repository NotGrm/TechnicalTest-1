# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    email { 'my_email@example.org' }
    firstname { 'john' }
    lastname { 'doe' }
  end
end
