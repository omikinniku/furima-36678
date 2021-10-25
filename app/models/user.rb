class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :orders

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "全角カタカナで入力してください"} # 全角カナ
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "全角カタカナで入力してください"}
  validates :birthday, presence: true
end
