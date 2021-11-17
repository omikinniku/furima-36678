class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_top, only: [:index, :create]
  before_action :set_order, only: [:index, :create]

  def index
    @order_buyer = OrderBuyer.new # 購入者情報を入れる空のインスタンス変数を設定
  end

  def create
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid? #ApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため
      pay_item
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,           # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                # 通貨の種類（日本円）
      )
  end


  private

  def move_to_top
    @item = Item.find(params[:item_id])
    # itemsテーブルのidとordersテーブルのitem_idが一致する = 商品は購入されている
    # ログイン時、売却済み商品、または自身が出品した商品の商品購入ページに遷移しようとすると、トップページへ
    if @item.user_id == current_user.id || @item.order != nil #ordersテーブルにあるitem_idがnil(空)でない時
      redirect_to root_path
    end
  end

  def set_order
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_buyer).permit(
      :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
end