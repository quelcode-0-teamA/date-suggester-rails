(1..4).each do |n|
  birth_year = 1980 + 5 * n
  User.seed do |s|
    s.id = n
    s.email = "seed_#{birth_year}@example.com"
    s.name = "seed_#{birth_year}"
    s.birth_year = birth_year
    s.gender = 1
    s.area_id = 1
    s.password = 'password'
    s.password_confirmation = 'password'
  end
end
