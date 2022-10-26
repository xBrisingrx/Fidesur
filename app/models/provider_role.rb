# == Schema Information
#
# Table name: provider_roles
#
#  id          :bigint           not null, primary key
#  active      :boolean
#  description :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ProviderRole < ApplicationRecord
end
