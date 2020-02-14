(1..10).each do |i|
  Plan.seed do |s|
    s.id = i
    s.title = "seed_#{i}"
    s.description = 'description'
    s.area_id = 1
  end
end
