# == Schema Information
#
# Table name: lands
#
#  id                                                                 :bigint           not null, primary key
#  active                                                             :boolean          default(TRUE)
#  code                                                               :string(255)
#  is_corner                                                          :boolean          default(FALSE)
#  is_green_space                                                     :boolean          default(FALSE)
#  land_type                                                          :integer          default("habitable")
#  measures                                                           :string(255)
#  price                                                              :decimal(15, 2)   default(0.0)
#  space_not_available(Espacio de el lote que no puede ser utilizado) :decimal(15, 2)   default(0.0)
#  status                                                             :integer          default("available")
#  surface                                                            :decimal(15, 2)   default(0.0)
#  ubication                                                          :string(255)
#  created_at                                                         :datetime         not null
#  updated_at                                                         :datetime         not null
#  apple_id                                                           :bigint
#  user_created_id                                                    :bigint
#  user_updated_id                                                    :bigint
#
# Indexes
#
#  index_lands_on_apple_id         (apple_id)
#  index_lands_on_user_created_id  (user_created_id)
#  index_lands_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (apple_id => apples.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
require 'test_helper'

class LandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
