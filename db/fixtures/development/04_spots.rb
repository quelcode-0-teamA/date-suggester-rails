cnt = 1
CSV.foreach('db/fixtures/development/spots.csv', headers: true) do |spot|
  Spot.seed do |s|
    s.id = spot['id'].to_i
    s.name = spot['name']
    s.description = spot['description']
    s.budget = spot['budget'].to_i
    s.thumb = spot['thumb']
    s.url = spot['url']
  end
  PlanSpot.seed do |s|
    s.id = cnt
    s.plan_id = spot['plan_id']
    s.spot_id = spot['id'].to_i
    s.order = spot['order'].to_i
    cnt += 1
  end
  Plan.find(spot['plan_id']).recalculation_total_budget
end
