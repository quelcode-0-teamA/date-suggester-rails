CSV.foreach('db/fixtures/development/plans.csv', headers: true) do |plan|
  Plan.seed do |s|
    s.id = plan['id'].to_i
    s.title = plan['title']
    s.description = plan['description']
    s.area_id = plan['area_id'].to_i
    s.thumb = plan['thumb']
  end
end
