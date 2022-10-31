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
class Land < ApplicationRecord
	belongs_to :apple
	belongs_to :user_created, class_name: "User"
	belongs_to :user_updated, class_name: "User"
	has_one_attached :blueprint

	# has_one :field_sale
	has_one :sale_product, as: :product # relacion entre venta y lote

	has_many :land_projects
	# Los lotes de una misma manzana no pueden llamarse igual
	validates :code, 
		presence: true,
		uniqueness: { scope: :apple_id,case_sensitive: false, message: "Ya existe un lote con esta denominación" }

	enum status: [:available, :bought, :canceled]
	enum land_type: [:habitable, :no_habitable, :green_space]	

	def reset_status
		self.status = :available
	end
end
