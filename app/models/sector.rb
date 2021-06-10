# == Schema Information
#
# Table name: sectors
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string(255)
#  size       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Sector < ApplicationRecord
	has_many :apples
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false, message: "Ya existe un sector con este nombre" }
end
