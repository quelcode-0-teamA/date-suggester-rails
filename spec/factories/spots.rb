FactoryBot.define do
  factory :spot do
    id { 1 }
    name { 'TOHOシネマ新宿' }
    description { 'ゴジラ、ゴジラ、ゴジラがやってくる' }
    prefectures { '新宿' }
    address { '東京都新宿区..' }
    budget { '2,500円' }
    tel { '03-1234-5678'}
    time { '2時間' }
    thumb { 'URL//image/path/..' }
    url { 'http://spot/url/..' }
    混み具合  { 'こみがっちー' }
    喫煙 { '喫煙おけ' }
    天気 { '雨天可だぜ' }
  end
end
