class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  # ログインしてなければ、ログイン画面へ
  before_action :move_to_index, only: [:edit]
  before_action :set_item, only: [:edit, :update, :show]

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
  # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクト
  def move_to_index
    @item = Item.find(params[:id])
    unless user_signed_in? && current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :image, :item_description, :category_id, :status_id, :ship_cost_id, :ship_days_id, :prefecture_id, :price
    ).merge(user_id: current_user.id)
  end
end
