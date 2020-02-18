FactoryBot.define do
  factory :plan do
    id { 1 }
    title { '映画デート' }
    description { '新宿でまったりと映画デート♪' }
    area { '新宿' }
    budget { '2,500円' }
    time { '4時間' }
    thumb { 'URL//image/path/..' }
    spots { 'hoge' }
  end
end
