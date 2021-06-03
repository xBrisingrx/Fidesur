class Client < ApplicationRecord
	validates :name, presence: true
	validates :last_name, presence: true
	validates :dni, uniqueness: { message: "Este dni pertenece a otro cliente" }, allow_blank: true
	validates :cuil, uniqueness: { message: "Este dni pertenece a otro cliente" }, allow_blank: true
	validates :code, uniqueness: { message: "Este legajo pertenece a otro cliente" }, allow_blank: true
end
