class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #下の記述は出品・購入機能で実装する記述
  # has_many :items
  # has_many :orders

  validates :nickname, presence: true
  validates :email, presence: true, format: { with: /@.+/, message: "@を入れてください"} # @が必要
  validates :password, presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "英数字混合で入力してください"} # 英数字混合
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "全角で入力してください"} # 全角
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "全角で入力してください"} 
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "全角カタカナで入力してください"} # 全角カナ
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "全角カタカナで入力してください"}
  validates :birthday, presence: true
end
