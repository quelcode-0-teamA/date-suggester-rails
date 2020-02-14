# budgetが指定値 * 5 と budgetがrandom * 5
cnt = 1
(1..10).each do |i|
  (1..2).each do |n|
    PlanSpot.seed do |s|
      s.id = cnt
      s.plan_id = i
      s.spot_id = cnt
      s.order = n
    end
    cnt += 1
  end
end
