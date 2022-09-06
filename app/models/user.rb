# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  rol             :integer
#  username        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :lands_created, class_name: 'Land', 
                            foreign_key: 'user_created_id'
  has_many :lands_updated, class_name: 'Land',
                            foreign_key: 'user_updated_id'

  validates :username, presence: true, uniqueness: { case_sensitive: false, message: "Este usuario ya se encuentra registrado" }
  validates :email, presence: true, uniqueness: { case_sensitive: false, message: "Este email de usuario se encuentra en uso" }
end
