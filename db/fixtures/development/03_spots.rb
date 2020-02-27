(1..20).each do |i|
  budget = 500 * (i / 2)
  Spot.seed do |s|
    s.id = i
    s.name = "seed_#{budget}"
    s.description = 'description'
    s.budget = budget
    s.tel = '000-0000-0000'
    s.url = 'URL://url.../..'
  end
end
