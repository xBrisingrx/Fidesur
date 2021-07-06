# == Schema Information
#
# Table name: apples
#
#  id                                                                    :bigint           not null, primary key
#  active                                                                :boolean          default(TRUE)
#  code                                                                  :string(255)
#  hectares                                                              :integer
#  location                                                              :string(255)
#  space_not_available(Espacio de la manzana que no puede ser utilizado) :decimal(15, 2)   default(0.0)
#  value                                                                 :float(24)        default(0.0)
#  created_at                                                            :datetime         not null
#  updated_at                                                            :datetime         not null
#  sector_id                                                             :bigint
#
# Indexes
#
#  index_apples_on_sector_id  (sector_id)
#
# Foreign Keys
#
#  fk_rails_...  (sector_id => sectors.id)
#
class Apple < ApplicationRecord
  belongs_to :sector
  has_many  :fields
  has_one_attached :blueprint
  
  validates :code, uniqueness: { case_sensitive: false, message: "Ya existe una manzana con esta denominación" }
end
