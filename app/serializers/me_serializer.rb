class MeSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :email,
              :token,
              :birth_year,
              :gender,
              :area_id,
              :created_at,
              :updated_at
end
