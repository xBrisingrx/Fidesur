# == Schema Information
#
# Table name: project_providers
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :bigint
#  provider_id     :bigint
#  user_created_id :bigint
#  user_updated_id :bigint
#
# Indexes
#
#  index_project_providers_on_project_id       (project_id)
#  index_project_providers_on_provider_id      (provider_id)
#  index_project_providers_on_user_created_id  (user_created_id)
#  index_project_providers_on_user_updated_id  (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (provider_id => providers.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
class ProjectProvider < ApplicationRecord
  belongs_to :project
  belongs_to :provider
end
