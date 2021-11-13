class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid? #ApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_buyer).permit(
      :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id)
  end
end