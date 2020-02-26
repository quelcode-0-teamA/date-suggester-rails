(1..3).each do |i|
  DateType.seed do |s|
    s.id = i.to_i
    s.title = 'ごはん'
  end
end
