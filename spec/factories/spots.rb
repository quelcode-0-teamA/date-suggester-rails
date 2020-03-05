# == Schema Information
#
# Table name: spots
#
#  id          :bigint           not null, primary key
#  budget      :integer          not null
#  description :text             not null
#  name        :string           not null
#  tel         :integer
#  thumb       :string           default("https://date-suggester.s3-ap-northeast-1.amazonaws.com/spot_default.jpg"), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :spot do
    name { 'TOHOシネマ新宿' }
    description { 'ゴジラ、ゴジラ、ゴジラがやってくる' }
    budget { 2500 }
  end
end
