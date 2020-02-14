(0..10).each do |n|
  budget = 1000 * n
  Spot.seed do |s|
    s.id = n + 1
    s.name = "seed_#{budget}"
    s.description = 'description'
    s.budget = budget
    s.tel = '000-0000-0000'
    s.url = 'URL://url.../..'
  end
end
