FactoryBot.define do
  factory :item do
    name             {"name"}
    item_description {"description"}
    category_id      {2}
    status_id        {2}
    ship_cost_id     {2}
    ship_days_id     {2}
    prefecture_id    {2}
    price            {1000}
    association :user

    # afterメソッドを用いて、インスタンス生成後に画像を保存
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end