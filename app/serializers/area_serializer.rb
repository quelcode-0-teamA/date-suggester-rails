# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  order      :integer          default("0"), not null
#  region     :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_areas_on_order   (order)
#  index_areas_on_region  (region)
#
class AreaSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :order
end
