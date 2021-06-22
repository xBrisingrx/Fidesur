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
  validates :username, presence: true, uniqueness: { case_sensitive: false, message: "Este email ya se encuentra registrado" }
  validates :email, presence: true, uniqueness: { case_sensitive: false, message: "Este nombre de usuario se encuentra en uso" }
end
