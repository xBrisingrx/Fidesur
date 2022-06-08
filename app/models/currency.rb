# == Schema Information
#
# Table name: currencies
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  detail     :string(255)
#  name       :string(40)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Currency < ApplicationRecord
end
