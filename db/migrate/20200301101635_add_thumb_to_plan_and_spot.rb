class AddThumbToPlanAndSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :thumb, :string, null: false, default: 'https://date-suggester.s3-ap-northeast-1.amazonaws.com/plan_default.jpg'
    add_column :spots, :thumb, :string, null: false, default: 'https://date-suggester.s3-ap-northeast-1.amazonaws.com/spot_default.jpg'
  end
end
