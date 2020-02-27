# UserTypesマスタ
(0..9).each do |i|
  (0..1).each do |n|
    UserType.seed do |s|
      m = i * 2 + n + 1
      s.id = m
      s.tens_place_age = i * 2 / 2
      s.early_or_late = n
      s.standard_budget = i * 2 < 10 ? m * 500 : 5000
    end
  end
end

# Areasマスタ
require 'csv'
csv = CSV.read('db/fixtures/development/areas.csv')
csv.each do |area|
  Area.seed do |s|
    s.id = area[0].to_i
    s.name = area[1]
    s.order = area[2].to_i
  end
end

# DateTypeマスタ
date_types = CSV.read('db/fixtures/development/date_types.csv')
date_types.each do |date_type|
  DateType.seed do |s|
    s.id = date_type[0].to_i
    s.name = date_type[1]
  end
end
