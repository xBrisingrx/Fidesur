# == Schema Information
#
# Table name: fields
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  code       :string(255)
#  measures   :string(255)
#  price      :decimal(15, 2)   default(0.0)
#  status     :integer          default("libre")
#  surface    :decimal(15, 2)   default(0.0)
#  ubication  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  apple_id   :bigint
#
# Indexes
#
#  index_fields_on_apple_id  (apple_id)
#
# Foreign Keys
#
#  fk_rails_...  (apple_id => apples.id)
#
class Field < ApplicationRecord
	belongs_to :apple

	enum status: [:libre, :comprado, :cancelado]
end
