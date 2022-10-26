# == Schema Information
#
# Table name: land_projects
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  land_id    :bigint
#  project_id :bigint
#
# Indexes
#
#  index_land_projects_on_land_id     (land_id)
#  index_land_projects_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (land_id => lands.id)
#  fk_rails_...  (project_id => projects.id)
#
class LandProject < ApplicationRecord
  belongs_to :land
  belongs_to :project
end
