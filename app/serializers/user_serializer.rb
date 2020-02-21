class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :email,
              :birth_year,
              :gender,
              :area_id
end
