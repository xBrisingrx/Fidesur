# == Schema Information
#
# Table name: project_providers
#
#  id                                                                                 :bigint           not null, primary key
#  active                                                                             :boolean          default(TRUE)
#  iva                                                                                :decimal(10, )
#  porcent(Porcentaje que representa el proveedor en el costo del proyecto)           :decimal(10, )
#  price(Lo que cobra)                                                                :decimal(10, )
#  price_calculate(Precio calculado cuando el proveedor cobra por porcentaje de obra) :decimal(10, )
#  created_at                                                                         :datetime         not null
#  updated_at                                                                         :datetime         not null
#  payment_method_id                                                                  :bigint
#  project_id                                                                         :bigint
#  provider_id                                                                        :bigint
#  provider_role_id                                                                   :bigint
#  user_created_id                                                                    :bigint
#  user_updated_id                                                                    :bigint
#
# Indexes
#
#  index_project_providers_on_payment_method_id  (payment_method_id)
#  index_project_providers_on_project_id         (project_id)
#  index_project_providers_on_provider_id        (provider_id)
#  index_project_providers_on_provider_role_id   (provider_role_id)
#  index_project_providers_on_user_created_id    (user_created_id)
#  index_project_providers_on_user_updated_id    (user_updated_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_method_id => payment_methods.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (provider_id => providers.id)
#  fk_rails_...  (provider_role_id => provider_roles.id)
#  fk_rails_...  (user_created_id => users.id)
#  fk_rails_...  (user_updated_id => users.id)
#
class ProjectProvider < ApplicationRecord
  belongs_to :project
  belongs_to :provider
  belongs_to :provider_role
  belongs_to :payment_method

  belongs_to :user_created, class_name: "User"
  belongs_to :user_updated, class_name: "User"
end
