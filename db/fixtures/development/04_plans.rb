(1..2).each do |n|
  Plan.seed do |s|
    s.id = n
    s.title = "seed_#{n}"
    s.description = 'description'
    s.area_id = 1
  end
end
