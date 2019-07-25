# frozen_string_literal: true

json.contact do
  json.id @contact.id
  json.email @contact.email
  json.lastname @contact.lastname
  json.firstname @contact.firstname
end
