class Apple < ApplicationRecord
  belongs_to :sector

  validates :code, uniqueness: { case_sensitive: false, message: "Ya existe una manzana con esta denominación" }
end
