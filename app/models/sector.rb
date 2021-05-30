class Sector < ApplicationRecord
	has_many :apples
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false, message: "Ya existe un sector con este nombre" }
end
