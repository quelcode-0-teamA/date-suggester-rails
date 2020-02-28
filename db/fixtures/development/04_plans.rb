cnt = 1
areas = Area.where('"order" > ?', 0).order_asc
areas.each do |area|
  10.times do
    Plan.seed do |s|
      s.id = cnt
      s.title = "seed_#{cnt}"
      s.description = 'description'
      s.area_id = area.id
    end
    cnt += 1
  end
end
