# == Schema Information
#
# Table name: providers
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  activity        :string(255)
#  cuit            :string(255)
#  description     :string(255)
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :bigint
#  user_updated_id :bigint
#
# Indexes
#
#  index_providers_on_user_created_id  (user_created_id)
#  index_providers_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
