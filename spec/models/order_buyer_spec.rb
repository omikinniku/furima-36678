require 'rails_helper'

RSpec.describe OrderBuyer, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_buyer = FactoryBot.build(:order_buyer, user_id: user.id, item_id: item.id)
    sleep 0.1 # 0.1秒待機
  end

  describe '商品購入' do
    context "購入できる時" do
      it "必須項目が全てあれば購入できる" do
        expect(@order_buyer).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @order_buyer.building_name = ''
        expect(@order_buyer).to be_valid
      end
    end
    
    context '購入ができない時' do
      it 'tokenが空だと購入できない' do
        @order_buyer.token = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Token can't be blank"
      end
      it 'postal_codeが空だと購入できない' do
        @order_buyer.postal_code = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Postal code can't be blank"
      end
      it 'postal_codeが半角のハイフンを含んでないと購入できない' do
        @order_buyer.postal_code = '1234567'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Postal code is invalid"
      end
      it 'prefecture_idを選択していないと購入できない' do
        @order_buyer.prefecture_id = 1
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Prefecture 選択してください"
      end
      it 'cityが空だと購入できない' do
        @order_buyer.city = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "City can't be blank"
      end
      it 'addtrssが空だと購入できない' do
        @order_buyer.address = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberが空だと購入できない' do
        @order_buyer.phone_number = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numberが9桁以下では購入できない' do
        @order_buyer.phone_number = '090123456'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Phone number 10桁または11桁の半角数字で入力してください"
      end
      it 'phone_numberが12桁以上では購入できない' do
        @order_buyer.phone_number = '090123456789'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Phone number 10桁または11桁の半角数字で入力してください"
      end
      it 'phone_numberが半角数字でないと購入できない' do
        @order_buyer.phone_number = '０９０１２３４５６７８'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number 10桁または11桁の半角数字で入力してください")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end