# == Schema Information
#
# Table name: client_fields
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  detail     :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#  field_id   :bigint
#
# Indexes
#
#  index_client_fields_on_client_id  (client_id)
#  index_client_fields_on_field_id   (field_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (field_id => fields.id)
#
class ClientField < ApplicationRecord
  belongs_to :client
  belongs_to :field
end
