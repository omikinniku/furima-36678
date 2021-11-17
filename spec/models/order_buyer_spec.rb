require 'rails_helper'

RSpec.describe OrderBuyer, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_buyer = FactoryBot.build(:order_buyer, user_id: user.id, item_id: item.id)
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
    end
  end
end