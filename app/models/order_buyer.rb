class OrderBuyer
  # Formオブジェクト使用
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A[0-9]{11}\z/ }
    validates :item_id
    validates :user_id
    validates :token
    #コントローラーのif @order_buyer.valid?でtokenが空の場合falseとなり、エラーメッセージを表示してくれる
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "選択してください"}

  def save
    # 各テーブルにデータを保存する処理
    order = Order.create(item_id: item_id, user_id: user_id)
    Buyer.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end