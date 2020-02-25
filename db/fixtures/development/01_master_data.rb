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

# Areasマスタ エリア設定きまるまで
require 'csv'
csv = CSV.read('db/fixtures/development/areas.csv')
csv.each do |area|
  Area.seed do |s|
    s.id = area[0].to_i
    s.name = area[1]
    s.order = area[2].to_i
  end
end
