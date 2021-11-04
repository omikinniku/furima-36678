class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  #ActiveHashを用いて belongs_toを設定するには、下記の記述でmoduleを取り込む。
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :cost
  belongs_to :days
  belongs_to :prefecture

  validates :name, presence: true
  validates :item_description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "選択してください"}
  validates :status_id, presence: true, numericality: { other_than: 1, message: "選択してください"}
  validates :ship_cost_id, presence: true, numericality: { other_than: 1, message: "選択してください"}
  validates :ship_days_id, presence: true, numericality: { other_than: 1, message: "選択してください"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "選択してください"}
  validates :price, presence: true
  validates :image, presence: true
end