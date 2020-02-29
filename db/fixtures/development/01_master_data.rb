require 'csv'

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
CSV.foreach('db/fixtures/development/areas.csv', headers: true) do |area|
  Area.seed do |s|
    s.id = area['id'].to_i
    s.name = area['area']
    s.order = area['order'].to_i
    s.region = area['region']
  end
end

# DateTypeマスタ
CSV.foreach('db/fixtures/development/date_types.csv', headers: true) do |date_type|
  DateType.seed do |s|
    s.id = date_type['id'].to_i
    s.name = date_type['date_type']
  end
end
