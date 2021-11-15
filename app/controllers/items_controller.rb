class ItemsController < ApplicationController
  # ログインしてなければ、ログイン画面へ
  before_action :authenticate_user!, only: [:new, :create, :edit]
  
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :move_to_top, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

  
  private
  def set_item
    @item = Item.find(params[:id])
  end

  # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクト
  # user_signed_in?の記述はauthenticate_user!が行ってくれるためここでは不要
  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def move_to_top
    # itemsテーブルのidとordersテーブルのitem_idが一致する = 商品は購入されている
    # ログイン時、自身が出品した売却済み商品の、商品情報編集ページに遷移しようとすると、トップページへ
    if @item.user_id != current_user.id || @item.order != nil #ordersテーブルにあるitem_idがnil(空)でない時
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :image, :item_description, :category_id, :status_id, :ship_cost_id, :ship_days_id, :prefecture_id, :price
    ).merge(user_id: current_user.id)
  end
end
