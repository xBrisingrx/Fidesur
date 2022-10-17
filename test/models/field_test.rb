# == Schema Information
#
# Table name: fields
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  code            :string(255)
#  field_type      :integer          default("habitable")
#  is_green_space  :boolean          default(FALSE)
#  measures        :string(255)
#  price           :decimal(15, 2)   default(0.0)
#  status          :integer          default("available")
#  surface         :decimal(15, 2)   default(0.0)
#  ubication       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  apple_id        :bigint
#  user_created_id :bigint           default(1)
#  user_updated_id :bigint           default(1)
#
# Indexes
#
#  index_fields_on_apple_id         (apple_id)
#  index_fields_on_user_created_id  (user_created_id)
#  index_fields_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (apple_id => apples.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
require 'test_helper'

class FieldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
