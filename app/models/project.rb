# == Schema Information
#
# Table name: projects
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  description     :text(65535)
#  name            :string(255)
#  number          :integer          not null
#  price           :decimal(15, 2)   default(0.0), not null
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_type_id :bigint
#  user_created_id :bigint
#  user_updated_id :bigint
#
# Indexes
#
#  index_projects_on_project_type_id  (project_type_id)
#  index_projects_on_user_created_id  (user_created_id)
#  index_projects_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_type_id => project_types.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
class Project < ApplicationRecord
  has_many :providers
  has_many :materials
  belongs_to :project_type
  belongs_to :user_created, class_name: "User"
  belongs_to :user_updated, class_name: "User"

  scope :actives, -> { where(active: true) }
  
  enum status: [:proceso, :terminado]
end
