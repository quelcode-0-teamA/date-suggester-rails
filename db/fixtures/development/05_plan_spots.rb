spot_cnt = 1
areas_count = Area.where('"order" > ?', 0).count
plans_count = areas_count * 10
(0...plans_count).each do |i|
  (1..3).each do |n|
    spot_cnt = 1 if spot_cnt > 20
    PlanSpot.seed do |s|
      s.id = (i * 3) + n
      s.plan_id = i + 1
      s.spot_id = spot_cnt
      s.order = n
    end
    spot_cnt += 1
  end
  Plan.find(i + 1).recalculation_total_budget
end
