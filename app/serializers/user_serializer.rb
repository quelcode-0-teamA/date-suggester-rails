# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birth_year      :integer          not null
#  email           :string
#  gender          :integer
#  name            :string
#  password_digest :string
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  area_id         :bigint           not null
#
# Indexes
#
#  index_users_on_area_id  (area_id)
#  index_users_on_email    (email) UNIQUE
#  index_users_on_token    (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :email,
              :birth_year,
              :gender,
              :avatar,
              :area

  def area
    AreaSerializer.new(object.area)
  end

  def avatar
    object.avatar_url
  end
end
