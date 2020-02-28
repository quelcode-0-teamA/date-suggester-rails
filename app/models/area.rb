class Area < ApplicationRecord
  validates :name, presence: true

  enum region: {
    unknown: 0, ueno_region: 1, ikebukuro_region: 2,
    shinjuku_region: 3, shibuya_region: 4,
    ebisu_region: 5, tokyo_station_region: 6
  }
end
