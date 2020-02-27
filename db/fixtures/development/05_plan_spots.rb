spot_cnt = 1
areas_count = Area.where('"order" > ?', 0).count
plans_count = areas_count * 10
(1..plans_count).each do |i|
  2.times do |n|
    spot_cnt = 1 if spot_cnt > 20
    PlanSpot.seed do |s|
      s.id = i + n
      s.plan_id = i
      s.spot_id = spot_cnt # 1..10
      s.order = n
    end
    spot_cnt += 1
  end
  Plan.find(i).recalculation_total_budget
end
