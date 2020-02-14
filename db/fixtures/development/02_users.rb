(1..4).each do |i|
  birth_year = 1980 + 5 * i
  User.seed do |s|
    s.id = i
    s.email = "seed_#{birth_year}@example.com"
    s.name = "seed_#{birth_year}"
    s.birth_year = birth_year
    s.gender = 1
    s.area_id = 1
    s.password = 'password'
    s.password_confirmation = 'password'
  end
end
