class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :birth_year,
              :gender,
              :area_id
end
