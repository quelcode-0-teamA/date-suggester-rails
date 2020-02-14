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
(0...47).each do |i|
  Area.seed do |s|
    s.id = i + 1
    s.name = "東京#{i + 1}"
  end
end
