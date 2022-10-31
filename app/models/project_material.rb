# == Schema Information
#
# Table name: project_materials
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  price           :decimal(10, )
#  units           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  material_id     :bigint
#  project_id      :bigint
#  user_created_id :bigint
#  user_updated_id :bigint
#
# Indexes
#
#  index_project_materials_on_material_id      (material_id)
#  index_project_materials_on_project_id       (project_id)
#  index_project_materials_on_user_created_id  (user_created_id)
#  index_project_materials_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (material_id => materials.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
class ProjectMaterial < ApplicationRecord
  belongs_to :project
  belongs_to :material

  belongs_to :user_created, class_name: "User"
  belongs_to :user_updated, class_name: "User"
end
