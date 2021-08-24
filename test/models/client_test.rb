# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  code(Legajo) :string(255)
#  direction    :string(255)
#  dni          :integer
#  email        :string(255)
#  last_name    :string(255)
#  name         :string(255)
#  phone        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
