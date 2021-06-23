# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  code(Legajo) :string(255)
#  cuil         :string(255)
#  dni          :integer
#  email        :string(255)
#  last_name    :string(255)
#  name         :string(255)
#  phone        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Client < ApplicationRecord

	has_many :client_fields

	validates :name, presence: true
	validates :last_name, presence: true
	validates :dni, uniqueness: { message: "Este dni pertenece a otro cliente" }, allow_blank: true
	validates :cuil, uniqueness: { message: "Este dni pertenece a otro cliente" }, allow_blank: true
	validates :code, uniqueness: { message: "Este legajo pertenece a otro cliente" }, allow_blank: true
end
