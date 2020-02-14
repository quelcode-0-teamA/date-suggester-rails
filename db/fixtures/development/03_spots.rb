(0..20).each do |i|
  budget = i < 10 ? 500 * i : 500 * rand(15)
  Spot.seed do |s|
    s.id = i + 1
    s.name = "seed_#{budget}"
    s.description = 'description'
    s.budget = budget
    s.tel = '000-0000-0000'
    s.url = 'URL://url.../..'
  end
end
