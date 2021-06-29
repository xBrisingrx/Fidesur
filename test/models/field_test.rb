# == Schema Information
#
# Table name: fields
#
#  id                                                                 :bigint           not null, primary key
#  active                                                             :boolean          default(TRUE)
#  code                                                               :string(255)
#  field_type                                                         :integer          default("habitable")
#  is_green_space                                                     :boolean          default(FALSE)
#  measures                                                           :string(255)
#  price                                                              :decimal(15, 2)   default(0.0)
#  space_not_available(Espacio de el lote que no puede ser utilizado) :decimal(15, 2)   default(0.0)
#  status                                                             :integer          default("available")
#  surface                                                            :decimal(15, 2)   default(0.0)
#  ubication                                                          :string(255)
#  created_at                                                         :datetime         not null
#  updated_at                                                         :datetime         not null
#  apple_id                                                           :bigint
#
# Indexes
#
#  index_fields_on_apple_id  (apple_id)
#
# Foreign Keys
#
#  fk_rails_...  (apple_id => apples.id)
#
require 'test_helper'

class FieldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
